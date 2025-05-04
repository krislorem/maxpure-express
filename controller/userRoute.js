import express from 'express'
import client from '../config/redis.js'
import { argonhash, argonverify } from '../util/argon.js';
import { verifyUserExistByEmail, getUserPasswordByEmail, getUserInfoByEmail, initUserByEmail } from '../service/user.js'
const router = express.Router()
router.post('/verify-code', async (req, res) => {
  const { email, code, password } = req.body

  const storedCode = await client.get(`code:${email}`)
  if (!storedCode) return res.status(400).json({ code: 1, message: "验证码已过期", data: {} });

  if (code !== storedCode) return res.status(401).json({ code: 1, message: "验证码错误", data: {} });

  await client.del(`code:${email}`)
  const user = await verifyUserExistByEmail(email)
  const hash = await argonhash(password)
  if (user.length === 0) {
    const id = await initUserByEmail(email, hash)
    console.log(`initUserByEmail: ${id}`)
    res.json({ code: 0, message: "验证成功", data: { id: id, email: email } })
  } else {
    const hashed = await getUserPasswordByEmail(email)
    console.log(`getUserPasswordByEmail: ${hashed}`)
    if (!argonverify(password, hashed)) {
      return res.status(401).json({ code: 1, message: "密码错误", data: {} });
    } else {
      const users = await getUserInfoByEmail(email)
      res.json({ code: 0, message: "验证成功", data: users })
    }
  }
});
export default router

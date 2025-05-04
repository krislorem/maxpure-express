import express from 'express';
import mail from '../config/mail.js';
import client from '../config/redis.js';
const router = express.Router();
router.post('/mail', async (req, res) => {
  try {
    const to = req.query.to;

    if (!to) {
      return res.status(400).json({ code: 1, message: "参数错误", data: {} });
    }
    const exists = await client.exists(`code:${to}`);
    if (exists) return res.status(429).json({ code: 0, message: "请求过于频繁", data: {} });
    await mail(to);

    res.json({
      code: 0,
      message: "验证码邮件发送成功",
      data: { to: to }
    });

  } catch (error) {
    console.error('邮件发送失败:', error);
    res.status(500).json({ code: 1, message: "邮件发送失败", data: {} });
  }
});
export default router;

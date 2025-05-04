import express from 'express';
import multer from 'multer';
import OSS from 'ali-oss';
const ossClient = new OSS({
  region: process.env.OSS_REGION,
  accessKeyId: process.env.OSS_ACCESS_KEY_ID,
  accessKeySecret: process.env.OSS_ACCESS_KEY_SECRET,
  bucket: process.env.OSS_BUCKET,
  endpoint: process.env.OSS_ENDPOINT,
  secure: true
});
const router = express.Router();
const upload = multer({ storage: multer.memoryStorage() })
router.post('/upload', upload.single('file'), async (req, res) => {
  try {
    const file = req.file;
    if (!file) return res.status(400).json({ code: 1, message: "未上传文件", data: {} });
    const ext = file.originalname.split('.').pop();
    const filename = `${process.env.OSS_DIR}/${new Date().toISOString().slice(0, 10)}/${Date.now()}.${ext}`;

    const result = await ossClient.put(filename, file.buffer, {
      headers: { 'Content-Type': file.mimetype }
    });

    res.json({ code: 0, message: "上传成功", data: { url: result.url } });
    console.log(`文件上传成功: ${result.url}`);
  } catch (err) {
    console.error('上传失败:', err);
    res.status(500).json({ code: 1, message: "上传失败", data: {} });
  }
});

export default router

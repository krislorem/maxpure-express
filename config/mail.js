import { createTransport } from 'nodemailer'
import client from './redis.js';
const generateCode = () => {
  let chars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
  ];
  let res = "";
  for (var i = 0; i < 6; i++) {
    let id = Math.floor(Math.random() * 36);
    res += chars[id];
  }
  return res;
}
const transporter = createTransport({
  host: process.env.MAIL_HOST,
  port: process.env.MAIL_PORT,
  secure: true,
  auth: {
    user: process.env.MAIL_USER,
    pass: process.env.MAIL_PASS
  }
})
transporter.verify((error, success) => {
  error ? console.log('SMTP error:', error) : console.log('SMTP ready', success)
})
const mail = async (to) => {
  const code = generateCode();
  // transporter.sendMail({
  //   from: '"Maxpure Note" <2145619745@qq.com>',
  //   to: to,
  //   subject: 'verification code',
  //   html: `
  //   <td style="padding: 20px 0; text-align: center; background-color: #f8f9fa">
  //                 <table role="presentation" width="600" cellspacing="0" cellpadding="0" border="0" align="center" style="
  //                     max-width: 90%;
  //                     background-color: #ffffff;
  //                     border-radius: 8px;
  //                     box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
  //                   ">

  //                   <tbody><tr>
  //                     <td style="
  //                         padding: 30px 40px;
  //                         text-align: center;
  //                         border-bottom: 1px solid #f1f1f1;
  //                       ">
  //                       <h1 style="margin: 0; color: #4a86e8; font-size: 24px">
  //                         novafield
  //                       </h1>
  //                       <p style="margin: 0; color: #666666; font-size: 16px">
  //                         Maxpure Note
  //                       </p>
  //                     </td>
  //                   </tr>

  //                   <tr>
  //                     <td style="padding: 40px">
  //                       <p style="
  //                           margin: 0 0 20px;
  //                           font-size: 16px;
  //                           line-height: 1.5;
  //                           color: #333333;
  //                         ">
  //                         Thank you for access www.novafield.cn. To complete your
  //                         verification, please use the following code:
  //                       </p>
  //                       <div style="margin: 30px 0; text-align: center">
  //                         <div style="
  //                             display: inline-block;
  //                             background-color: #f7f9fc;
  //                             border-radius: 6px;
  //                             padding: 15px 25px;
  //                             border: 1px dashed #d0d0d0;
  //                           ">
  //                           <span style="
  //                               font-size: 32px;
  //                               font-weight: bold;
  //                               letter-spacing: 5px;
  //                               color: #4a86e8;
  //                               font-family: monospace;
  //                             ">${code}</span>
  //                         </div>
  //                       </div>
  //                       <p style="
  //                           margin: 20px 0 0;
  //                           font-size: 16px;
  //                           line-height: 1.5;
  //                           color: #333333;
  //                         ">
  //                         This code will expire in 1 minutes. If you didn't request
  //                         this code, please ignore this email.
  //                       </p>
  //                     </td>
  //                   </tr>

  //                   <tr>
  //                     <td style="
  //                         padding: 20px 40px;
  //                         text-align: center;
  //                         background-color: #f8f9fa;
  //                         border-top: 1px solid #f1f1f1;
  //                         border-radius: 0 0 8px 8px;
  //                       ">
  //                       <p style="margin: 0; color: #999999; font-size: 14px">
  //                         © 2025 www.novafield.cn. All rights
  //                         reserved.
  //                       </p>
  //                       <p style="margin: 0; color: #999999; font-size: 13px">
  //                         Enjoy your note journey with Maxpure Note.
  //                       </p>
  //                     </td>
  //                   </tr>
  //                 </tbody></table>
  //               </td>
  //   `
  // }, (err, info) => {
  //   err ? console.log('mail error:', err) : console.log(`mail to ${to} success`, info)
  // })
  await client.setEx(`code:${to}`, 60, code)
  console.log(`code generated: ${code}`)
}

export default mail

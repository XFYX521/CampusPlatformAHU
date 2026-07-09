const nodemailer = require('nodemailer');
//这里负责填写发送验证邮件的邮箱与密码
const transporter = nodemailer.createTransport({
  host: 'smtp.example.com',
  port: example,
  secure: true,
  auth: {
    user: 'example@example.com',
    pass: 'example'
  }
});

function sendVerificationCode(email, code) {
  return transporter.sendMail({
    from: '"注册验证码" <example>',
    to: email,
    subject: '注册验证码',
    html: '<div style="padding:20px;font-family:sans-serif">' +
      '<p style="color:#7f8c8d;font-size:14px">您的注册验证码为：</p>' +
      '<p style="font-size:32px;font-weight:bold;color:#3498db;letter-spacing:8px;text-align:center;padding:20px;background:#f8f9fa;border-radius:8px">' + code + '</p>' +
      '<p style="color:#95a5a6;font-size:12px">验证码有效期为5分钟，请勿泄露给他人。</p></div>'
  });
}

module.exports = { sendVerificationCode };

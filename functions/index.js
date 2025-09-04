const functions = require("firebase-functions");
const nodemailer = require("nodemailer");
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "tumeloerro6@gmail.com",
    pass: "./Magnificent@80352",
  },
});
exports.sendEmail = functions.https.onRequest((req, res) => {
  const mailOptions = {
    from: "tumeloerro6@gmail.com",
    to: "tumeloerro6@outlook.com",
    subject: "Web customer Enquiry",
    text: `Name: ${req.body.name}\nPhone: ${req.body.phone}\n` +
          `Message: ${req.body.message}\nReplyEmail: ${req.body.email}`,
  };
  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      return res.status(500).send(error.toString());
    }
    return res.status(200).send("Email sent: " + info.response);
  });
});

const Student = require("../database/models").student;
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const { v4: uuidv4 } = require("uuid");
module.exports = {
  async getAllStudents(req, res) {
    await Student.findAll().then((students) => {
      res.send(students);
    });
  },
  async login(req, res) {
    const { email, password } = req.body;
    await Student.findOne({
      where: {
        email,
      },
    }).then(async (student) => {
      if (student) {
        const comparePass = bcrypt.compareSync(password, student.password);
        if (comparePass) {
          const token = await jwt.sign(
            {
              student,
            },
            process.env.JWT_SECRET
          );
          req.student = student;
          return res
            .status(200)
            .json({ success: "login success", token, student });
        }
      }
      return res.status(400).json({ error: "account not exist" });
    });
  },
  async register(req, res) {
    const { email, password } = req.body;
    await Student.findOne({
      where: {
        email,
      },
    }).then(async (student) => {
      if (!student) {
        const salt = bcrypt.genSaltSync(12);
        const newpassword = bcrypt.hashSync(password, salt);
        return await Student.create({
          id: uuidv4(),
          email,
          password: newpassword,
          isDeleted: false,
        }).then((newUser) => {
          if (!newUser) {
            return res.status(400).json({ error: "something went wrongs" });
          }
          return res.status(201).json({
            success: "register success",
          });
        });
      }
      return res.status(400).json({ error: "account is existing" });
    });
  },
  async logOut(req, res) {},
  async updateInfo(req, res) {},
};

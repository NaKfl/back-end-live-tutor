const router = require('express').Router();
const {
  getAllStudents,
  login,
  register,
  //   logOut,
} = require('../controller/student.controller');
// const auth = require('../middleware/auth')
router.get('/', getAllStudents);
router.post('/login', login);
router.post('/register', register);
// router.post('/logout',logOut)
module.exports = router;

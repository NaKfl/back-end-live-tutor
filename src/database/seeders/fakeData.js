const faker = require('faker');
const moment = require('moment');

// Default password: 123132
const defaultPassword =
  '$2a$12$VvWghIAnvkFgVG1hZ6OGyeaDtEPKGxZYmEu9PExiuke2WCDS5Fywe';

// Fake 3 role ids for tutor, student, admin
const roleIds = {
  tutor: faker.random.uuid(),
  student: faker.random.uuid(),
  admin: faker.random.uuid(),
};

// Fake 50 tutors
const tutors = [...Array(50)].map(() => ({
  id: faker.random.uuid(),
  email: faker.internet.email(),
  password: defaultPassword,
  name: `${faker.name.firstName()} ${faker.name.lastName()}`,
  avatar:
    'https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png',
  country: faker.address.country(),
  phone: faker.phone.phoneNumber(),
  language: faker.lorem.words(),
  birthday: faker.date.past(),
  isActivated: false,
  createdAt: new Date(),
  updatedAt: new Date(),
  requestPassword: false,
}));

// Fake 50 students
const students = [...Array(50)].map(() => ({
  id: faker.random.uuid(),
  email: faker.internet.email(),
  password: defaultPassword,
  name: `${faker.name.firstName()} ${faker.name.lastName()}`,
  avatar:
    'https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png',
  country: faker.address.country(),
  phone: faker.phone.phoneNumber(),
  language: faker.lorem.words(),
  birthday: faker.date.past(),
  isActivated: false,
  createdAt: new Date(),
  updatedAt: new Date(),
  requestPassword: false,
}));

const users = [...students, ...tutors];

// Set role for 50 tutors
const tutorRoles = tutors
  .map((tutor) => tutor.id)
  .map((id) => ({
    userId: id,
    roleId: roleIds.tutor,
    createdAt: new Date(),
    updatedAt: new Date(),
  }));

// Set role for 50 students
const studentRoles = students
  .map((student) => student.id)
  .map((id) => ({
    userId: id,
    roleId: roleIds.student,
    createdAt: new Date(),
    updatedAt: new Date(),
  }));

const tutorInfo = tutors
  .map((tutor) => tutor.id)
  .map((id) => ({
    id: faker.random.uuid(),
    userId: id,
    video: faker.internet.url(),
    bio: faker.lorem.sentence(),
    languages: [
      ...Array(
        faker.random.number({
          min: 1,
          max: 4,
        }),
      ),
    ].map(() => faker.lorem.word()),
    specialties: [
      ...Array(
        faker.random.number({
          min: 1,
          max: 5,
        }),
      ),
    ].map(() => faker.lorem.word()),
    resume: faker.lorem.paragraph(),
    education: faker.lorem.paragraph(),
    experience: faker.lorem.paragraph(),
    interests: faker.lorem.paragraph(),
    profession: faker.lorem.words(),
    accent: faker.lorem.words(),
    targetStudent: faker.lorem.words(),
    createdAt: new Date(),
    updatedAt: new Date(),
    isActivated: true,
  }));

const favoriteTutors = [...Array(200)].map(() => ({
  id: faker.random.uuid(),
  firstId:
    students[
      faker.random.number({
        min: 0,
        max: 49,
      })
    ].id,
  secondId:
    tutors[
      faker.random.number({
        min: 0,
        max: 49,
      })
    ].id,
  createdAt: new Date(),
  updatedAt: new Date(),
}));

const messages = [...Array(1000)].map(() => ({
  id: faker.random.uuid(),
  fromId:
    users[
      faker.random.number({
        min: 0,
        max: 99,
      })
    ].id,
  toId:
    users[
      faker.random.number({
        min: 0,
        max: 99,
      })
    ].id,
  isRead: false,
  content: faker.lorem.paragraph(),
  createdAt: new Date(),
  updatedAt: new Date(),
}));

const schedules = [...Array(100)].map(() => ({
  id: faker.random.uuid(),
  tutorId:
    tutors[
      faker.random.number({
        min: 0,
        max: 49,
      })
    ].id,
  date: moment(faker.date.future()).format('YYYY-MM-DD'),
  endTime: moment(faker.date.future()).format('HH:mm'),
  startTime: moment(faker.date.future()).format('HH:mm'),
  createdAt: new Date(),
  updatedAt: new Date(),
}));

const scheduleDetails = [...Array(300)].map(() => ({
  id: faker.random.uuid(),
  scheduleId:
    schedules[
      faker.random.number({
        min: 0,
        max: 99,
      })
    ].id,
  endPeriod: moment(faker.date.future()).format('HH:mm'),
  startPeriod: moment(faker.date.future()).format('HH:mm'),
  createdAt: new Date(),
  updatedAt: new Date(),
}));

const bookings = [...Array(150)].map(() => ({
  id: faker.random.uuid(),
  scheduleDetailId:
    scheduleDetails[
      faker.random.number({
        min: 0,
        max: 299,
      })
    ].id,
  userId:
    students[
      faker.random.number({
        min: 0,
        max: 49,
      })
    ].id,
  createdAt: new Date(),
  updatedAt: new Date(),
}));

const imageURLs = [
  'https://camblycurriculumicons.s3.amazonaws.com/5eb03d0f9934e038cfcf0372?h=d41d8cd98f00b204e9800998ecf8427e',
  'https://camblycurriculumicons.s3.amazonaws.com/5e2b895e541a832674533c18?h=d41d8cd98f00b204e9800998ecf8427e',
  'https://camblycurriculumicons.s3.amazonaws.com/5e7e51cca52da4ab4bd958e6?h=d41d8cd98f00b204e9800998ecf8427e',
  'https://camblycurriculumicons.s3.amazonaws.com/5fd9240c4143a75bf6c2de8b?h=d41d8cd98f00b204e9800998ecf8427e',
];

const levels = ['Beginner', 'Intermediate', 'Advanced'];

// Fake 50 course
const courses = [...Array(50)].map(() => ({
  id: faker.random.uuid(),
  tutorId:
    tutorInfo[
      faker.random.number({
        min: 0,
        max: 49,
      })
    ].userId,
  name: faker.lorem.sentence(),
  description: faker.lorem.paragraph(),
  level:
    levels[
      faker.random.number({
        min: 0,
        max: 2,
      })
    ],
  other_details: faker.lorem.sentence(),
  imageUrl:
    imageURLs[
      faker.random.number({
        min: 0,
        max: 3,
      })
    ],
  default_price: faker.random.number({
    min: 100,
    max: 500,
  }),
  course_price: faker.random.number({
    min: 100,
    max: 500,
  }),
  createdAt: new Date(),
  updatedAt: new Date(),
}));

const topics = courses.reduce((pre, now) => {
  const topic = [...Array(10)].map((_, index) => ({
    id: faker.random.uuid(),
    courseId: now.id,
    orderCourse: index,
    name: faker.lorem.sentence(),
    description: faker.lorem.paragraph(),
    videoUrl: faker.lorem.sentence(),
    createdAt: new Date(),
    updatedAt: new Date(),
  }));
  return [...pre, ...topic];
}, []);

const MAJOR_NAMES = [
  { englishName: 'Foreign Languages', vietnameseName: 'Ngoại ngữ' },
  { englishName: 'Marketing', vietnameseName: 'Marketing' },
  { englishName: 'Office Information', vietnameseName: 'Tin học văn phòng' },
  { englishName: 'Design', vietnameseName: 'Thiết kế' },
  { englishName: 'Business', vietnameseName: 'Kinh doanh' },
  { englishName: 'Health Care', vietnameseName: 'Chăm sóc sức khỏe' },
  {
    englishName: 'Information Technology',
    vietnameseName: 'Công nghệ thông tin',
  },
];

const majors = MAJOR_NAMES.map(({ englishName, vietnameseName }) => ({
  id: faker.random.uuid(),
  englishName,
  vietnameseName,
  createdAt: new Date(),
  updatedAt: new Date(),
}));

module.exports = {
  tutors,
  students,
  defaultPassword,
  roleIds,
  tutorRoles,
  studentRoles,
  tutorInfo,
  favoriteTutors,
  messages,
  schedules,
  scheduleDetails,
  bookings,
  topics,
  courses,
  majors,
  up: () => Promise.resolve(),
  down: () => Promise.resolve(),
};

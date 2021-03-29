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
  endTime: moment(faker.date.future()).format('YYYY-MM-DD HH:mm:ss'),
  startTime: moment(faker.date.future()).format('YYYY-MM-DD HH:mm:ss'),
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
  endPeriod: moment(faker.date.future()).format('YYYY-MM-DD HH:mm:ss'),
  startPeriod: moment(faker.date.future()).format('YYYY-MM-DD HH:mm:ss'),
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
  up: () => Promise.resolve(),
  down: () => Promise.resolve(),
};

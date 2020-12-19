const faker = require('faker');

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
  avatar: faker.internet.avatar(),
  country: faker.address.country(),
  phone: faker.phone.phoneNumber(),
  isDeleted: false,
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
  avatar: faker.internet.avatar(),
  country: faker.address.country(),
  phone: faker.phone.phoneNumber(),
  isDeleted: false,
  isActivated: false,
  createdAt: new Date(),
  updatedAt: new Date(),
}));

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
  up: () => Promise.resolve(),
  down: () => Promise.resolve(),
};

'use strict';

const fakeData = require('./fakeData');

const { courses } = fakeData;

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert('Courses', [...courses], {});
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('Courses', null, {});
  },
};

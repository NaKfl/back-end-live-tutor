'use strict';

const fakeData = require('./fakeData');

const { tutorInfo } = fakeData;

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert('Tutors', [...tutorInfo], {});
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('Tutors', null, {});
  },
};

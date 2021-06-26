'use strict';

const fakeData = require('./fakeData');

const { majors } = fakeData;

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert('Majors', [...majors], {});
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('Majors', null, {});
  },
};

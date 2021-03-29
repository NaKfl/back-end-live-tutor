'use strict';

const fakeData = require('./fakeData');

const { schedules } = fakeData;

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert('Schedules', [...schedules], {});
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('Schedules', null, {});
  },
};

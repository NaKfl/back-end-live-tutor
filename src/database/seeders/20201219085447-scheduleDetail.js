'use strict';

const fakeData = require('./fakeData');

const { scheduleDetails } = fakeData;

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert(
      'ScheduleDetails',
      [...scheduleDetails],
      {},
    );
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('ScheduleDetails', null, {});
  },
};

'use strict';

const fakeData = require('./fakeData');

const { feeTutor } = fakeData;

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert('FeeTutors', [...feeTutor], {});
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('FeeTutors', null, {});
  },
};

'use strict';

const fakeData = require('./fakeData');

const { reports } = fakeData;

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert('Reports', [...reports], {});
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('Reports', null, {});
  },
};

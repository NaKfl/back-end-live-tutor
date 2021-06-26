'use strict';

const fakeData = require('./fakeData');

const { types } = fakeData;

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert('Types', [...types], {});
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('Types', null, {});
  },
};

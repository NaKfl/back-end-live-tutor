'use strict';

const fakeData = require('./fakeData');

const { fees } = fakeData;

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert('Fees', [...fees], {});
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('Fees', null, {});
  },
};

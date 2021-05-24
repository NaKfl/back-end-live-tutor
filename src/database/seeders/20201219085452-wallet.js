'use strict';

const fakeData = require('./fakeData');

const { wallets } = fakeData;

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert('Wallets', [...wallets], {});
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('Wallets', null, {});
  },
};

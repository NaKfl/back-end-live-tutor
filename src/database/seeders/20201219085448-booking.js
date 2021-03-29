'use strict';

const fakeData = require('./fakeData');

const { bookings } = fakeData;

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert('Bookings', [...bookings], {});
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('Bookings', null, {});
  },
};

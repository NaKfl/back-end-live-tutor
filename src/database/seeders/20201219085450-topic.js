'use strict';

const fakeData = require('./fakeData');

const { topics } = fakeData;

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert('Topics', [...topics], {});
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('Topics', null, {});
  },
};

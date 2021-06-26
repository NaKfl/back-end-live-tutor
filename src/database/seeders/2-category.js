'use strict';

const fakeData = require('./fakeData');

const { languageCategory, specialtieCategory } = fakeData;

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert(
      'Categories',
      [...languageCategory, ...specialtieCategory],
      {},
    );
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('Categories', null, {});
  },
};

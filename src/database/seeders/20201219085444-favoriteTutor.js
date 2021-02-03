'use strict';

const fakeData = require('./fakeData');

const { favoriteTutors } = fakeData;

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert('FavoriteTutors', [...favoriteTutors], {});
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('FavoriteTutors', null, {});
  },
};

'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await Promise.all([
      queryInterface.addColumn('Topics', 'nameFile', Sequelize.TEXT),
    ]);
  },
  down: async (queryInterface) => {
    await Promise.all([
      await queryInterface.removeColumn('Topics', 'nameFile'),
    ]);
  },
};

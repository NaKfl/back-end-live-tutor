'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await Promise.all([
      queryInterface.removeColumn('Courses', 'tutorId'),
      queryInterface.addColumn('Courses', 'reason', Sequelize.TEXT),
      queryInterface.addColumn('Courses', 'purpose', Sequelize.TEXT),
    ]);
  },
  down: async (queryInterface, Sequelize) => {
    await Promise.all([
      await queryInterface.addColumn('Courses', 'tutorId', Sequelize.UUID),
    ]);
  },
};

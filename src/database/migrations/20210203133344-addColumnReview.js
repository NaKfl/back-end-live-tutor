'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await Promise.all([
      queryInterface.addColumn(
        'CallSessions',
        'isTutorReviewed',
        Sequelize.BOOLEAN,
      ),
    ]);
  },
  down: async (queryInterface) => {
    await Promise.all([
      await queryInterface.removeColumn('CallSessions', 'isTutorReviewed'),
    ]);
  },
};

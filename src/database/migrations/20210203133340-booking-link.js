'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await Promise.all([
      queryInterface.addColumn('Bookings', 'tutorMeetingLink', Sequelize.TEXT),
      queryInterface.addColumn(
        'Bookings',
        'studentMeetingLink',
        Sequelize.TEXT,
      ),
    ]);
  },
  down: async (queryInterface) => {
    await Promise.all([
      await queryInterface.removeColumn('Bookings', 'tutorMeetingLink'),
      await queryInterface.removeColumn('Bookings', 'studentMeetingLink'),
    ]);
  },
};

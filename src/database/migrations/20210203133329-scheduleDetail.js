'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('ScheduleDetails', {
      id: {
        allowNull: false,
        autoIncrement: false,
        primaryKey: true,
        type: Sequelize.UUID,
      },
      startPeriod: {
        allowNull: false,
        type: Sequelize.STRING,
      },
      endPeriod: {
        allowNull: false,
        type: Sequelize.STRING,
      },
      scheduleId: {
        allowNull: false,
        type: Sequelize.UUID,
        references: {
          model: 'Schedules',
          key: 'id',
        },
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE,
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE,
      },
    });
  },
  down: async (queryInterface) => {
    await queryInterface.dropTable('ScheduleDetails');
  },
};

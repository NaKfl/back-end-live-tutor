'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('TutorFeedbacks', {
      id: {
        allowNull: false,
        autoIncrement: false,
        primaryKey: true,
        type: Sequelize.UUID,
      },
      firstId: {
        type: Sequelize.UUID,
        allowNull: false,
      },
      secondId: {
        type: Sequelize.UUID,
        allowNull: false,
      },
      rating:{
        type: Sequelize.FLOAT,
        allowNull: false,
      },
      content:{
        type: Sequelize.TEXT,
        allowNull: false,
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
    await queryInterface.dropTable('TutorFeedbacks');
  },
};

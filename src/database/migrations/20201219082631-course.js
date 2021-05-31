'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('Courses', {
      id: {
        allowNull: false,
        primaryKey: true,
        type: Sequelize.UUID,
      },
      tutorId: {
        type: Sequelize.UUID,
        allowNull: false,
        references: {
          model: 'Users',
          key: 'id',
        },
      },
      name: { type: Sequelize.TEXT },
      description: { type: Sequelize.TEXT },
      level: { type: Sequelize.TEXT },
      other_details: { type: Sequelize.TEXT },
      imageUrl: { type: Sequelize.TEXT },
      default_price: { type: Sequelize.FLOAT },
      course_price: { type: Sequelize.FLOAT },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE,
        defaultValue: Sequelize.fn('now'),
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE,
        defaultValue: Sequelize.fn('now'),
      },
    });
  },

  down: async (queryInterface) => {
    await queryInterface.dropTable('Courses');
  },
};

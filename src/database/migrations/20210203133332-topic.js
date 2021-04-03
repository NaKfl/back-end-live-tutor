'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('Topics', {
      id: {
        allowNull: false,
        primaryKey: true,
        type: Sequelize.UUID,
        defaultValue: Sequelize.UUIDV4,
      },
      courseId: {
        allowNull: false,
        type: Sequelize.UUID,
        references: {
          model: 'Courses',
          key: 'id',
        },
      },
      name: { type: Sequelize.TEXT },
      description: { type: Sequelize.TEXT },
      orderCourse: { type: Sequelize.INTEGER },
      videoUrl: { type: Sequelize.TEXT },
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
    await queryInterface.dropTable('Topics');
  },
};

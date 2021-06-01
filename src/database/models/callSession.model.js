'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class CallSession extends Model {
    static associate(models) {
      this.belongsTo(models.User, {
        foreignKey: 'tutorId',
        as: 'tutorInfo',
      });
      this.belongsTo(models.User, {
        foreignKey: 'studentId',
        as: 'studentInfo',
      });
    }
  }
  CallSession.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      studentId: {
        allowNull: false,
        type: DataTypes.UUID,
        references: {
          model: 'User',
          key: 'id',
        },
      },
      tutorId: {
        allowNull: false,
        type: DataTypes.UUID,
        references: {
          model: 'User',
          key: 'id',
        },
      },
      videoUrl: {
        type: DataTypes.STRING,
        allowNull: true,
        defaultValue: null,
      },
      startTime: {
        allowNull: false,
        type: DataTypes.DATE,
      },
      endTime: {
        allowNull: false,
        type: DataTypes.DATE,
      },
      isReviewed: { type: DataTypes.BOOLEAN, defaultValue: false },
      createdAt: DataTypes.DATE,
      updatedAt: DataTypes.DATE,
    },
    {
      sequelize,
      modelName: 'CallSession',
    },
  );
  return CallSession;
};

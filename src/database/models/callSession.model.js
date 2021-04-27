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
      this.hasOne(models.TutorFeedback, {
        foreignKey: 'id',
        as: 'feedbackInfo',
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
      feedbackId: {
        allowNull: true,
        type: DataTypes.UUID,
        defaultValue: null,
        references: {
          model: 'TutorFeedback',
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
      createdAt: { type: DataTypes.DATE, defaultValue: new Date() },
      updatedAt: { type: DataTypes.DATE, defaultValue: new Date() },
    },
    {
      sequelize,
      modelName: 'CallSession',
    },
  );
  return CallSession;
};

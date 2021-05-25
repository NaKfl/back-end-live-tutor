'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Booking extends Model {
    static associate(models) {
      this.belongsTo(models.User, {
        foreignKey: 'userId',
        as: 'userInfo',
      });
      this.belongsTo(models.ScheduleDetail, {
        foreignKey: 'scheduleDetailId',
        as: 'scheduleDetailInfo',
      });
    }
  }
  Booking.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      userId: DataTypes.UUID,
      scheduleDetailId: {
        type: DataTypes.UUID,
        allowNull: false,
        references: {
          model: 'ScheduleDetail',
          key: 'id',
        },
      },
      createdAt: { type: DataTypes.DATE, defaultValue: new Date() },
      updatedAt: { type: DataTypes.DATE, defaultValue: new Date() },
    },
    {
      sequelize,
      modelName: 'Booking',
    },
  );
  return Booking;
};

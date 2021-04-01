'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class ScheduleDetail extends Model {
    static associate(models) {
      this.belongsTo(models.Schedule, {
        foreignKey: 'scheduleId',
        as: 'scheduleInfo',
      });
      this.hasMany(models.Booking, {
        foreignKey: 'scheduleDetailId',
        as: 'bookingInfo',
      });
    }
  }
  ScheduleDetail.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      scheduleId: DataTypes.UUID,
      startPeriod: { type: DataTypes.STRING },
      endPeriod: { type: DataTypes.STRING },
      createdAt: { type: DataTypes.DATE, defaultValue: new Date() },
      updatedAt: { type: DataTypes.DATE, defaultValue: new Date() },
    },
    {
      sequelize,
      modelName: 'ScheduleDetail',
    },
  );
  return ScheduleDetail;
};

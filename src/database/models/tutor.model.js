'use strict';

const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Tutor extends Model {
    static associate(models) {
      this.belongsTo(models.User, {
        foreignKey: 'userId',
      });
    }
  }

  Tutor.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      userId: {
        type: DataTypes.UUID,
        allowNull: false,
        references: {
          model: 'User',
          key: 'id',
        },
      },
      video: DataTypes.STRING,
      bio: DataTypes.TEXT,
      education: DataTypes.TEXT,
      experience: DataTypes.TEXT,
      profession: DataTypes.TEXT,
      accent: DataTypes.STRING,
      targetStudent: DataTypes.STRING,
      interests: DataTypes.TEXT,
      languages: DataTypes.STRING,
      specialties: DataTypes.STRING,
      resume: DataTypes.TEXT,
      isActivated: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: false,
      },
    },
    {
      sequelize,
      modelName: 'Tutor',
    },
  );

  return Tutor;
};

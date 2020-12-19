'use strict';

const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Tutor extends Model {
    static associate(models) {
      this.belongsTo(models.User);
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
      languages: DataTypes.ARRAY(DataTypes.STRING),
      specialties: DataTypes.ARRAY(DataTypes.STRING),
      resume: DataTypes.TEXT,
    },
    {
      sequelize,
      modelName: 'Tutor',
    },
  );

  return Tutor;
};

export const pick = (object, keys) => {
  if (!keys) return object;
  return keys.reduce((obj, key) => {
    if (object && key in object) {
      obj[key] = object[key];
    }
    return obj;
  }, {});
};

export const exclude = (object, keys) => {
  if (!keys) return object;
  return Object.keys(object.dataValues).reduce((obj, key) => {
    if (object && !keys.includes(key)) {
      obj[key] = object[key];
    }
    return obj;
  }, {});
};

export const flatObjectsByKeys = (objects, flattedKeys) => {
  return objects.map((obj) => {
    for (const [key, value] of Object.entries(obj)) {
      if (flattedKeys.includes(key)) {
        delete obj[key];
        obj = { ...obj, ...value };
      }
    }
    return obj;
  });
};

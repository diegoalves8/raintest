const db = require('./db');
const helper = require('../helper');
const config = require('../config');

async function getMultiple(page = 1){
  const offset = helper.getOffset(page, config.listPerPage);
  const rows = await db.query(
    `SELECT id, name, birthday_year
    FROM rainus_db LIMIT 20`, 
    [offset, config.listPerPage]
  );
  const data = helper.emptyOrRows(rows);
  const meta = {page};

  return {
    data,
    meta
  }
}

async function create(rainus){
  const result = await db.query(
    `INSERT INTO rainus_db 
    (name, birthday_year) 
    VALUES 
    (?, ?)`, 
    [
      rainus.name, rainus.birthday_year
    ]
  );

  let message = 'Error creating your file';

  if (result.affectedRows) {
    message = 'Record created successfully';
  }

  return {message};
}

async function update(id, rainus){
  const result = await db.query(
    `UPDATE rainus_db 
    SET name=?, birthday_year=?,
    WHERE id=?`, 
    [
      rainus.name, rainus.birthday_year,
       id
    ]
  );

  let message = 'Error updating your record';

  if (result.affectedRows) {
    message = 'Record updated successfully';
  }

  return {message};
}

async function remove(id){
  const result = await db.query(
    `DELETE FROM rainus_db WHERE id=?`, 
    [id]
  );

  let message = 'Error in deleting your record';

  if (result.affectedRows) {
    message = 'Record deleted successfully';
  }

  return {message};
}

module.exports = {
  getMultiple,
  create,
  update,
  remove
}

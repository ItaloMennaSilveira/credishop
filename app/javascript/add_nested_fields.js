window.addFields = function (association) {
  const container = document.getElementById(association);

  const singularMap = {
    contacts: 'contact',
    addresses: 'address'
  };

  const singular = singularMap[association];
  if (!container || !singular) return;

  const template = document.getElementById(`${singular}-template`);
  if (!template) return;

  const newId = new Date().getTime();
  let html = template.innerHTML.replace(/NEW_RECORD/g, newId);

  container.insertAdjacentHTML('beforeend', html);
};


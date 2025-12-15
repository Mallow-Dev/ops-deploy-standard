#!/usr/bin/env node
const { loginWithAppRole, readSecretKV } = require('./vault-client');
(async function(){
  try{
    const role = process.env.VAULT_ROLE_ID;
    const secret = process.env.VAULT_SECRET_ID;
    if(!role||!secret) { console.error('VAULT_ROLE_ID and VAULT_SECRET_ID must be set'); process.exit(2); }
    const token = await loginWithAppRole(role, secret);
    console.log('Login ok, token length', token.length);
    const s = await readSecretKV('demo', token);
    console.log('Read secrets keys:', Object.keys(s));
  }catch(e){
    console.error('Vault validate error:', e.message||e);
    process.exit(3);
  }
})();

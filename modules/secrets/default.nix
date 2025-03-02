{
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.agenix.nixosModules.default
    inputs.agenix-rekey.nixosModules.default
  ];

  age.rekey = {
    masterIdentities = [
      {
        identity = inputs.self + "/secrets/yubikey.pub";
        pubkey = "age1yubikey1qff5k54lavr7nx7m93sccygfcek7l9x8899mnq09nq6ksqdgtuaa5tj2v7y";
      }
    ];
    storageMode = "local";
    localStorageDir = inputs.self.outPath + "/secrets/rekeyed/${config.networking.hostName}";
    generatedSecretsDir = inputs.self.outPath + "/secrets/generated/${config.networking.hostName}";
  };
}

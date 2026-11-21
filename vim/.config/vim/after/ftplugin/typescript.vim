command! -buffer BiomeQF call helpers#qf_from_cmd('Biome', 'biome check --reporter github', '::%t%*[^,],file=%f,line=%l%*[^,],col=%c%*[^:]:%m')
command! -buffer TSQF call helpers#qf_from_cmd('typescript', 'bun run tsc --noEmit --pretty false', '%f(%l\,%c): %t%*[^:]: %m')

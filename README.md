Projeto de tratamento e limpeza de dados para PowerBI

Foram utilizados:
Azure para persistir o banco de dados;
MySQL para conecção local com o servidor azure;
PowerQuery para obtenção e tratamento dos dados do banco de dados Azure;
PowerBI para visualização de dados;

Ações realizadas:
Revisão dos tipos de dados de cata tabela;
Correção de valores nulos e inconsistentes;
Separação de colunas complexas;
Mescla de colunas simples em colunas complexas;
Junção de tabelas para criação de diferentes visualizações de dados;
Eliminação de colunas desnecessárias.

Diferença entre mesclar e Atrituir/Acrescentar consultas:

✅ Mesclar Consultas (Merge Queries)

O que faz: Junta colunas de duas tabelas com base em uma ou mais chaves correspondentes (similar a um JOIN no SQL).
Resultado: Uma única tabela com as colunas da primeira consulta e as colunas da segunda adicionadas conforme a correspondência.
Tipos de junção:

Inner (somente correspondências)
Left Outer (mantém todas as linhas da primeira tabela)
Right Outer, Full Outer, Anti Join etc.


Quando usar:

Para enriquecer dados com atributos de outra tabela (ex.: trazer nome do departamento para cada funcionário).
Para substituir chaves naturais por surrogate keys.
Para criar relações entre fatos e dimensões antes de carregar no modelo.

✅ Acrescentar Consultas (Append Queries)

O que faz: Empilha linhas de duas ou mais tabelas com mesma estrutura (similar a um UNION ALL no SQL).
Resultado: Uma única tabela contendo todas as linhas das tabelas originais.
Quando usar:

Para consolidar dados históricos (ex.: juntar arquivos mensais de vendas).
Para unificar fontes diferentes que representam a mesma entidade (ex.: duas listas de projetos).
Para criar uma tabela única a partir de várias partições.


Resposta: Foi utilizado Mesclar consultas para as tarefas de lincar Subordinados e Gerentes e de lincar Employee e departamentos pois a estrutura das tabelas era diferente, 
dessa forma foi necessário adicionas as colunas de uma tabela na outra para então ficarmos com as informaçõoes desejadas

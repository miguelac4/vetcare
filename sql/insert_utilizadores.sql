INSERT INTO utilizador (nome, email, password, role) VALUES
('Rita Rececionista', 'rececionista@vetcare.pt', LOWER(SHA2('testestestes', 256)), 'rececionista'),
('Vasco Veterinario',  'veterinario@vetcare.pt',  LOWER(SHA2('testestestes', 256)), 'veterinario'),
('Tiago Tutor',        'tutor@gmail.pt',        LOWER(SHA2('testestestes', 256)), 'tutor'),
('Guilherme Gerente',  'gerente@vetcare.pt',      LOWER(SHA2('testestestes', 256)), 'gerente');

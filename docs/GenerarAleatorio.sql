-- Este query genera un valir único de 6 caracteres compuesto por
-- 3 caracteres iniciales de la parte hexadecimal de un valor MDS aleatorio,
-- seguido de 3 caracteres que representan un número aleatorio entre 0 y 999,
-- con cercos a la izquierda para completar la longitud de 3
SELECT CONCAT(SUBSTRING(MD5(RAND()),1,3),LPAD(FLOOR(RAND()*1000),3,'0'))
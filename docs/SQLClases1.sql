USE mesadepartes

SELECT * FROM tm_usuario

INSERT INTO tm_usuario (usu_nomape, usu_correo, usu_pass) 
VALUES ('Dario Alberto Ayarza Medina', 'darioayarza1992@gmail.com', 'dario123lol')

SELECT * FROM tm_usuario
WHERE usu_correo = 'dayarza@soluzioni.group'

-- Este query genera un valir único de 6 caracteres compuesto por
-- 3 caracteres iniciales de la parte hexadecimal de un valor MDS aleatorio,
-- seguido de 3 caracteres que representan un número aleatorio entre 0 y 999,
-- con cercos a la izquierda para completar la longitud de 3
SELECT CONCAT(SUBSTRING(MD5(RAND()),1,3),LPAD(FLOOR(RAND()*1000),3,'0'))


SELECT * FROM tm_area

INSERT INTO tm_area (area_nom, area_correo, est)
VALUES ('Soporte L1', 'dayarza@soluzioni.pe', 1)


SELECT * FROM tm_tramite

SELECT * FROM tm_tipo

SELECT * FROM tm_documento

INSERT INTO tm_documento (area_id, tra_id, doc_externo, tip_id, doc_dni, doc_nom, doc_descrip, usu_id)
VALUES (1, 1, 'TEST', 1, '71407053', 'TEST NOMBRE', 'DESCRIPCION PRUEBA', 1)

SELECT * FROM td_documento_detalle

INSERT INTO td_documento_detalle (doc_id, det_nom, usu_id)
VALUES (1, 'test.pdf', 1)

DELIMITER //
CREATE PROCEDURE sp_l_documento_01(IN xdoc_id INT)
BEGIN
	SELECT
	tm_documento.doc_id,
	tm_documento.area_id,
	tm_area.area_nom,
	tm_area.area_correo,
	tm_documento.doc_externo,
	tm_documento.doc_dni,
	tm_documento.doc_nom,
	tm_documento.doc_descrip,
	tm_documento.tra_id,
	tm_tramite.tra_nom,
	tm_documento.tip_id,
	tm_tipo.tip_nom,
	tm_documento.usu_id,
	tm_usuario.usu_nomape,
	tm_usuario.usu_correo,
	contador.cant
	FROM tm_documento
	INNER JOIN tm_area ON tm_documento.area_id = tm_area.area_id
	INNER JOIN tm_tramite ON tm_documento.tra_id = tm_tramite.tra_id
	INNER JOIN tm_tipo ON tm_documento.tip_id = tm_tipo.tip_id
	INNER JOIN tm_usuario ON tm_documento.usu_id = tm_usuario.usu_id
	INNER JOIN (
		SELECT doc_id, COUNT(*) AS cant
		FROM td_documento_detalle
		WHERE doc_id = xdoc_id
		GROUP BY doc_id
	) contador ON tm_documento.doc_id = contador.doc_id
	WHERE tm_documento.doc_id = xdoc_id;
END //
DELIMITER ;

CALL sp_l_documento_01(17)

SELECT CONCAT(DATE_FORMAT(fech_crea,'%m'), '-',DATE_FORMAT(fech_crea,'%Y'), '-', doc_id) 
AS nrotramite FROM tm_documento

UPDATE tm_documento
SET fech_crea = NOW()

DROP PROCEDURE sp_l_documento_01

SELECT COUNT(*) AS cant FROM td_documento_detalle WHERE doc_id = 1

UPDATE tm_area
SET fech_crea = NOW()


DELIMITER //
CREATE PROCEDURE sp_l_documento_02(IN xusu_id INT)
BEGIN
	SELECT
	tm_documento.doc_id,
	tm_documento.area_id,
	tm_area.area_nom,
	tm_area.area_correo,
	tm_documento.doc_externo,
	tm_documento.doc_dni,
	tm_documento.doc_nom,
	tm_documento.doc_descrip,
	tm_documento.tra_id,
	tm_tramite.tra_nom,
	tm_documento.tip_id,
	tm_tipo.tip_nom,
	tm_documento.usu_id,
	tm_usuario.usu_nomape,
	tm_usuario.usu_correo,
	CONCAT(DATE_FORMAT(tm_documento.fech_crea,'%m'), '-',DATE_FORMAT(tm_documento.fech_crea,'%Y'), '-', tm_documento.doc_id) AS nrotramite
	FROM tm_documento
	INNER JOIN tm_area ON tm_documento.area_id = tm_area.area_id
	INNER JOIN tm_tramite ON tm_documento.tra_id = tm_tramite.tra_id
	INNER JOIN tm_tipo ON tm_documento.tip_id = tm_tipo.tip_id
	INNER JOIN tm_usuario ON tm_documento.usu_id = tm_usuario.usu_id
	WHERE tm_documento.usu_id = xusu_id;
END //
DELIMITER ;

CALL sp_l_documento_02(37)

SELECT * FROM tm_usuario







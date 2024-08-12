-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema psicoapp
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `psicoapp` ;

-- -----------------------------------------------------
-- Schema psicoapp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `psicoapp` DEFAULT CHARACTER SET utf8 ;
USE `psicoapp` ;

-- -----------------------------------------------------
-- Table `psicoapp`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `psicoapp`.`location` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(255) NOT NULL,
  `district` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `psicoapp`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `psicoapp`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `psicoapp`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `psicoapp`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `linkedin` VARCHAR(255) NULL,
  `age` INT NULL,
  `gender` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `created_at` DATETIME NULL,
  `type_of_account` TINYINT(2) NOT NULL,
  `modalidad` VARCHAR(255) NOT NULL,
  `cdr` VARCHAR(255) NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `psicoapp`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `psicoapp`.`address` (
  `location_id`  INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`location_id`, `user_id`),
    FOREIGN KEY (`location_id`)
    REFERENCES `psicoapp`.`location` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`user_id`)
    REFERENCES `psicoapp`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `psicoapp`.`education`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `psicoapp`.`education` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `school_name` VARCHAR(255) NOT NULL,
  `title_name` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `therapist_id` INT NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`therapist_id`)
    REFERENCES `psicoapp`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table `psicoapp`.`mensajes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `psicoapp`.`mensajes` (
 `id` INT NOT NULL AUTO_INCREMENT,
  `sender_id` INT NOT NULL,
  `reciever_id` INT NOT NULL,
  `text` TEXT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`sender_id`)
    REFERENCES `psicoapp`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`reciever_id`)
    REFERENCES `psicoapp`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `psicoapp`.`publications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `psicoapp`.`publications` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title`  VARCHAR(255)  NOT NULL,
  `description`  VARCHAR(400) NOT NULL,
  `created_at`  DATETIME NOT NULL,
  `file` VARCHAR(255) NULL,
  `publication_link` TEXT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`)
    REFERENCES `psicoapp`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `psicoapp`.`articles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `psicoapp`.`articles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `body` TEXT NOT NULL,
  `created_at` VARCHAR(255) NOT NULL,
  `img_filename` VARCHAR(255) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`)
    REFERENCES `psicoapp`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `psicoapp`.`user_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `psicoapp`.`user_categories` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `category_id`),
    FOREIGN KEY (`user_id`)
    REFERENCES `psicoapp`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`category_id`)
    REFERENCES `psicoapp`.`category` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `psicoapp`.`publication_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `psicoapp`.`publication_categories` (
  `publication_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`publication_id`, `category_id`),
    FOREIGN KEY (`publication_id`)
    REFERENCES `psicoapp`.`publications` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`category_id`)
    REFERENCES `psicoapp`.`category` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `psicoapp`.`article_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `psicoapp`.`article_categories` (
  `article_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`article_id`, `category_id`),
    FOREIGN KEY (`article_id`)
    REFERENCES `psicoapp`.`articles` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`category_id`)
    REFERENCES `psicoapp`.`category` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

ALTER TABLE `psicoapp`.`users` 
ADD COLUMN `confirmation_hash` VARCHAR(6) NULL AFTER `cdr`,
ADD COLUMN `validated` TINYINT NULL AFTER `confirmation_hash`,
CHANGE COLUMN `type_of_account` `type` TINYINT NOT NULL ;


ALTER TABLE `psicoapp`.`users` 
ADD COLUMN `metodo` VARCHAR(255) NULL AFTER `validated`;


ALTER TABLE `psicoapp`.`users` 
CHANGE COLUMN `modalidad` `modalidad` VARCHAR(255) NULL ;


ALTER TABLE `psicoapp`.`category` 
RENAME TO  `psicoapp`.`categories` ;


ALTER TABLE `psicoapp`.`articles` 
ADD COLUMN `bibliography` TEXT NULL AFTER `user_id`;

ALTER TABLE `psicoapp`.`articles` 
ADD COLUMN `subtitle` VARCHAR(400) NOT NULL AFTER `bibliography`;

ALTER TABLE `psicoapp`.`users` 
ADD COLUMN `city` VARCHAR(255) NULL AFTER `metodo`;


ALTER TABLE `psicoapp`.`publications` 
ADD COLUMN `publisher` VARCHAR(255) NOT NULL AFTER `user_id`,
ADD COLUMN `date` DATE NOT NULL AFTER `publisher`;
ALTER TABLE `psicoapp`.`publications` 
CHANGE COLUMN `file` `file` VARCHAR(255) NOT NULL ,
CHANGE COLUMN `publication_link` `publication_link` TEXT NOT NULL ;

ALTER TABLE `psicoapp`.`users` 
ADD COLUMN `profile_path` VARCHAR(255) NULL AFTER `city`;


INSERT INTO categories (name) VALUES ("Anxiety"),("Depression"),("Stress"),("Trauma"),("PTSD"),("Grief and Loss"),("Eating Disorders"),("Obsessive-Compulsive Disorder (OCD)"),("Attention-Deficit Hyperactivity Disorder (ADHD)"),("Autism Spectrum Disorder"),("Borderline Personality Disorder"),("Schizophrenia"),("Bipolar Disorder"),("Dissociative Identity Disorder"),("Substance Abuse"),("Addiction"),("Anger Management"),("Relationship Issues"),("Marriage and Couples Counseling"),("Family Therapy"),("Parenting"),("Child Psychology"),("Adolescent Psychology"),("Aging and Geriatric Psychology"),("Career Counseling"),("Workplace Issues"),("Educational Psychology"),("Sports Psychology"),("Forensic Psychology"),("Military Psychology"),("Neuropsychology"),("Evolutionary Psychology"),("Cross-Cultural Psychology"),("Social Psychology"),("Cognitive Psychology"),("Developmental Psychology"),("Abnormal Psychology"),("Personality Psychology"),("Positive Psychology"),("Clinical Psychology"),("Counseling Psychology"),("Community Psychology"),("Health Psychology"),("Rehabilitation Psychology"),("School Psychology"),("Industrial-Organizational Psychology"),("Gender and Sexuality"),("Environmental Psychology"),("Consumer Psychology"),("Political Psychology"),("Media Psychology"),("Spirituality and Religion"),("Technology and Psychology"),("Police and Law Enforcement Psychology"),("Animals and Psychology"),("Disaster and Emergency Psychology"),("Fitness and Exercise Psychology"),("Food and Nutrition Psychology"),("Hospital and Medical Psychology");

--- inserts location ---
INSERT INTO location (city, district) VALUES 
('Región de Arica y Parinacota', 'Arica'),
('Región de Arica y Parinacota', 'Camarones'),
('Región de Arica y Parinacota', 'General Lagos'),
('Región de Arica y Parinacota', 'Putre')

INSERT INTO location (city, district) VALUES 
('Región de Tarapacá', 'Alto Hospicio'),
('Región de Tarapacá', 'Camiña'),
('Región de Tarapacá', 'Colchane'),
('Región de Tarapacá', 'Huara'),
('Región de Tarapacá', 'Iquique'),
('Región de Tarapacá', 'Pica'),
('Región de Tarapacá', 'Pozo Almonte')

INSERT INTO location (city, district) VALUES 
('Región de Antofagasta', 'Antofagasta'),
('Región de Antofagasta', 'Calama'),
('Región de Antofagasta', 'María Elena'),
('Región de Antofagasta', 'Mejillones'),
('Región de Antofagasta', 'Ollagüe'),
('Región de Antofagasta', 'San Pedro de Atacama'),
('Región de Antofagasta', 'Sierra Gorda'),
('Región de Antofagasta', 'Taltal'),
('Región de Antofagasta', 'Tocopilla')

INSERT INTO location (city, district) VALUES 
('Región de Atacama', 'Alto del Carmen'),
('Región de Atacama', 'Caldera'),
('Región de Atacama', 'Chañaral'),
('Región de Atacama', 'Copiapó'),
('Región de Atacama', 'Diego de Almagro'),
('Región de Atacama', 'Freirina'),
('Región de Atacama', 'Huasco'),
('Región de Atacama', 'Tierra Amarilla'),
('Región de Atacama', 'Vallenar')

INSERT INTO location (city, district) VALUES 
('Región de Coquimbo', 'Andacollo'),
('Región de Coquimbo', 'Canela'),
('Región de Coquimbo', 'Combarbalá'),
('Región de Coquimbo', 'Coquimbo'),
('Región de Coquimbo', 'Illapel'),
('Región de Coquimbo', 'La Higuera'),
('Región de Coquimbo', 'La Serena'),
('Región de Coquimbo', 'Los Vilos'),
('Región de Coquimbo', 'Monte Patria'),
('Región de Coquimbo', 'Ovalle'),
('Región de Coquimbo', 'Paihuano'),
('Región de Coquimbo', 'Punitaqui'),
('Región de Coquimbo', 'Río Hurtado'),
('Región de Coquimbo', 'Salamanca'),
('Región de Coquimbo', 'Vicuña')

INSERT INTO location (city, district) VALUES 
('Región de Valparaíso', 'Algarrobo'),
('Región de Valparaíso', 'Cabildo'),
('Región de Valparaíso', 'Calle Larga'),
('Región de Valparaíso', 'Cartagena'),
('Región de Valparaíso', 'Casablanca'),
('Región de Valparaíso', 'Catemu'),
('Región de Valparaíso', 'Concón'),
('Región de Valparaíso', 'El Quisco'),
('Región de Valparaíso', 'El Tabo'),
('Región de Valparaíso', 'Hijuelas'),
('Región de Valparaíso', 'Isla de Pascua'),
('Región de Valparaíso', 'Juan Fernández'),
('Región de Valparaíso', 'La Calera'),
('Región de Valparaíso', 'La Cruz'),
('Región de Valparaíso', 'La Ligua'),
('Región de Valparaíso', 'Limache'),
('Región de Valparaíso', 'Llaillay'),
('Región de Valparaíso', 'Los Andes'),
('Región de Valparaíso', 'Nogales'),
('Región de Valparaíso', 'Olmué'),
('Región de Valparaíso', 'Panquehue'),
('Región de Valparaíso', 'Papudo'),
('Región de Valparaíso', 'Petorca'),
('Región de Valparaíso', 'Puchuncaví'),
('Región de Valparaíso', 'Putaendo'),
('Región de Valparaíso', 'Quillota'),
('Región de Valparaíso', 'Quilpué'),
('Región de Valparaíso', 'Quintero'),
('Región de Valparaíso', 'Rinconada'),
('Región de Valparaíso', 'San Antonio'),
('Región de Valparaíso', 'San Esteban'),
('Región de Valparaíso', 'San Felipe'),
('Región de Valparaíso', 'Santa María'),
('Región de Valparaíso', 'Santo Domingo'),
('Región de Valparaíso', 'Valparaíso'),
('Región de Valparaíso', 'Villa Alemana'),
('Región de Valparaíso', 'Viña del Mar'),
('Región de Valparaíso', 'Zapallar')

INSERT INTO location (city, district) VALUES 
('Región Metropolitana de Santiago', 'Alhué'),
('Región Metropolitana de Santiago', 'Buin'),
('Región Metropolitana de Santiago', 'Calera de Tango'),
('Región Metropolitana de Santiago', 'Cerrillos'),
('Región Metropolitana de Santiago', 'Cerro Navia'),
('Región Metropolitana de Santiago', 'Colina'),
('Región Metropolitana de Santiago', 'Conchalí'),
('Región Metropolitana de Santiago', 'Curacaví'),
('Región Metropolitana de Santiago', 'El Bosque'),
('Región Metropolitana de Santiago', 'El Monte'),
('Región Metropolitana de Santiago', 'Estación Central'),
('Región Metropolitana de Santiago', 'Huechuraba'),
('Región Metropolitana de Santiago', 'Independencia'),
('Región Metropolitana de Santiago', 'Isla de Maipo'),
('Región Metropolitana de Santiago', 'La Cisterna'),
('Región Metropolitana de Santiago', 'La Florida'),
('Región Metropolitana de Santiago', 'La Granja'),
('Región Metropolitana de Santiago', 'Lampa'),
('Región Metropolitana de Santiago', 'La Pintana'),
('Región Metropolitana de Santiago', 'La Reina'),
('Región Metropolitana de Santiago', 'Las Condes'),
('Región Metropolitana de Santiago', 'Lo Barnechea'),
('Región Metropolitana de Santiago', 'Lo Espejo'),
('Región Metropolitana de Santiago', 'Lo Prado'),
('Región Metropolitana de Santiago', 'Macul'),
('Región Metropolitana de Santiago', 'Maipú'),
('Región Metropolitana de Santiago', 'María Pinto'),
('Región Metropolitana de Santiago', 'Melipilla'),
('Región Metropolitana de Santiago', 'Ñuñoa'),
('Región Metropolitana de Santiago', 'Padre Hurtado'),
('Región Metropolitana de Santiago', 'Paine'),
('Región Metropolitana de Santiago', 'Pedro Aguirre Cerda'),
('Región Metropolitana de Santiago', 'Peñaflor'),
('Región Metropolitana de Santiago', 'Peñalolén'),
('Región Metropolitana de Santiago', 'Pirque'),
('Región Metropolitana de Santiago', 'Providencia'),
('Región Metropolitana de Santiago', 'Pudahuel'),
('Región Metropolitana de Santiago', 'Puente Alto'),
('Región Metropolitana de Santiago', 'Quilicura'),
('Región Metropolitana de Santiago', 'Quinta Normal'),
('Región Metropolitana de Santiago', 'Recoleta'),
('Región Metropolitana de Santiago', 'Renca'),
('Región Metropolitana de Santiago', 'San Bernardo'),
('Región Metropolitana de Santiago', 'San Joaquín'),
('Región Metropolitana de Santiago', 'San José de Maipo'),
('Región Metropolitana de Santiago', 'San Miguel'),
('Región Metropolitana de Santiago', 'San Pedro'),
('Región Metropolitana de Santiago', 'San Ramón'),
('Región Metropolitana de Santiago', 'Santiago'),
('Región Metropolitana de Santiago', 'Talagante'),
('Región Metropolitana de Santiago', 'Tiltil'),
('Región Metropolitana de Santiago', 'Vitacura')


INSERT INTO location (city, district) VALUES 
('Región del Libertador Gral. Bernardo OHiggins', 'Chépica'),
('Región del Libertador Gral. Bernardo OHiggins', 'Chimbarongo'),
('Región del Libertador Gral. Bernardo OHiggins', 'Codegua'),
('Región del Libertador Gral. Bernardo OHiggins', 'Coinco'),
('Región del Libertador Gral. Bernardo OHiggins', 'Coltauco'),
('Región del Libertador Gral. Bernardo OHiggins', 'Doñihue'),
('Región del Libertador Gral. Bernardo OHiggins', 'Graneros'),
('Región del Libertador Gral. Bernardo OHiggins', 'La Estrella'),
('Región del Libertador Gral. Bernardo OHiggins', 'Las Cabras'),
('Región del Libertador Gral. Bernardo OHiggins', 'Litueche'),
('Región del Libertador Gral. Bernardo OHiggins', 'Lolol'),
('Región del Libertador Gral. Bernardo OHiggins', 'Machalí'),
('Región del Libertador Gral. Bernardo OHiggins', 'Malloa'),
('Región del Libertador Gral. Bernardo OHiggins', 'Marchihue'),
('Región del Libertador Gral. Bernardo OHiggins', 'Mostazal'),
('Región del Libertador Gral. Bernardo OHiggins', 'Nancagua'),
('Región del Libertador Gral. Bernardo OHiggins', 'Navidad'),
('Región del Libertador Gral. Bernardo OHiggins', 'Olivar'),
('Región del Libertador Gral. Bernardo OHiggins', 'Palmilla'),
('Región del Libertador Gral. Bernardo OHiggins', 'Paredones'),
('Región del Libertador Gral. Bernardo OHiggins', 'Peralillo'),
('Región del Libertador Gral. Bernardo OHiggins', 'Peumo'),
('Región del Libertador Gral. Bernardo OHiggins', 'Pichidegua'),
('Región del Libertador Gral. Bernardo OHiggins', 'Pichilemu'),
('Región del Libertador Gral. Bernardo OHiggins', 'Placilla'),
('Región del Libertador Gral. Bernardo OHiggins', 'Pumanque'),
('Región del Libertador Gral. Bernardo OHiggins', 'Quinta de Tilcoco'),
('Región del Libertador Gral. Bernardo OHiggins', 'Rancagua'),
('Región del Libertador Gral. Bernardo OHiggins', 'Rengo'),
('Región del Libertador Gral. Bernardo OHiggins', 'Requínoa'),
('Región del Libertador Gral. Bernardo OHiggins', 'San Fernando'),
('Región del Libertador Gral. Bernardo OHiggins', 'Santa Cruz'),
('Región del Libertador Gral. Bernardo OHiggins', 'San Vicente')


INSERT INTO location (city, district) VALUES 
('Región del Maule', 'Cauquenes'),
('Región del Maule', 'Chanco'),
('Región del Maule', 'Colbún'),
('Región del Maule', 'Constitución'),
('Región del Maule', 'Curepto'),
('Región del Maule', 'Curicó'),
('Región del Maule', 'Empedrado'),
('Región del Maule', 'Hualañé'),
('Región del Maule', 'Licantén'),
('Región del Maule', 'Linares'),
('Región del Maule', 'Longaví'),
('Región del Maule', 'Maule'),
('Región del Maule', 'Molina'),
('Región del Maule', 'Parral'),
('Región del Maule', 'Pelarco'),
('Región del Maule', 'Pelluhue'),
('Región del Maule', 'Pencahue'),
('Región del Maule', 'Rauco'),
('Región del Maule', 'Retiro'),
('Región del Maule', 'Río Claro'),
('Región del Maule', 'Romeral'),
('Región del Maule', 'Sagrada Familia'),
('Región del Maule', 'San Clemente'),
('Región del Maule', 'San Javier'),
('Región del Maule', 'San Rafael'),
('Región del Maule', 'Talca'),
('Región del Maule', 'Teno'),
('Región del Maule', 'Vichuquén'),
('Región del Maule', 'Villa Alegre'),
('Región del Maule', 'Yerbas Buenas')


INSERT INTO location (city, district) VALUES 
('Región de Ñuble', 'Bulnes'),
('Región de Ñuble', 'Chillán'),
('Región de Ñuble', 'Chillán Viejo'),
('Región de Ñuble', 'Cobquecura'),
('Región de Ñuble', 'Coelemu'),
('Región de Ñuble', 'Coihueco'),
('Región de Ñuble', 'El Carmen'),
('Región de Ñuble', 'Ninhue'),
('Región de Ñuble', 'Ñiquén'),
('Región de Ñuble', 'Pemuco'),
('Región de Ñuble', 'Pinto'),
('Región de Ñuble', 'Portezuelo'),
('Región de Ñuble', 'Quillón'),
('Región de Ñuble', 'Quirihue'),
('Región de Ñuble', 'Ránquil'),
('Región de Ñuble', 'San Carlos'),
('Región de Ñuble', 'San Fabián'),
('Región de Ñuble', 'San Ignacio'),
('Región de Ñuble', 'San Nicolás'),
('Región de Ñuble', 'Treguaco'),
('Región de Ñuble', 'Yungay')

INSERT INTO location (city, district) VALUES 
('Región del Biobío', 'Alto Biobío'),
('Región del Biobío', 'Antuco'),
('Región del Biobío', 'Arauco'),
('Región del Biobío', 'Cabrero'),
('Región del Biobío', 'Cañete'),
('Región del Biobío', 'Chiguayante'),
('Región del Biobío', 'Concepción'),
('Región del Biobío', 'Contulmo'),
('Región del Biobío', 'Coronel'),
('Región del Biobío', 'Curanilahue'),
('Región del Biobío', 'Florida'),
('Región del Biobío', 'Hualpén'),
('Región del Biobío', 'Hualqui'),
('Región del Biobío', 'Laja'),
('Región del Biobío', 'Lebu'),
('Región del Biobío', 'Los Alamos'),
('Región del Biobío', 'Los Angeles'),
('Región del Biobío', 'Lota'),
('Región del Biobío', 'Mulchén'),
('Región del Biobío', 'Nacimiento'),
('Región del Biobío', 'Negrete'),
('Región del Biobío', 'Penco'),
('Región del Biobío', 'Quilaco'),
('Región del Biobío', 'Quilleco'),
('Región del Biobío', 'San Pedro de la Paz'),
('Región del Biobío', 'San Rosendo'),
('Región del Biobío', 'Santa Bárbara'),
('Región del Biobío', 'Santa Juana'),
('Región del Biobío', 'Talcahuano'),
('Región del Biobío', 'Tirúa'),
('Región del Biobío', 'Tomé'),
('Región del Biobío', 'Tucapel'),
('Región del Biobío', 'Yumbel')

INSERT INTO location (city, district) VALUES 
('Región de La Araucanía', 'Angol'),
('Región de La Araucanía', 'Carahue'),
('Región de La Araucanía', 'Cholchol'),
('Región de La Araucanía', 'Collipulli'),
('Región de La Araucanía', 'Cunco'),
('Región de La Araucanía', 'Curacautín'),
('Región de La Araucanía', 'Curarrehue'),
('Región de La Araucanía', 'Ercilla'),
('Región de La Araucanía', 'Freire'),
('Región de La Araucanía', 'Galvarino'),
('Región de La Araucanía', 'Gorbea'),
('Región de La Araucanía', 'Lautaro'),
('Región de La Araucanía', 'Loncoche'),
('Región de La Araucanía', 'Lonquimay'),
('Región de La Araucanía', 'Los Sauces'),
('Región de La Araucanía', 'Lumaco'),
('Región de La Araucanía', 'Melipeuco'),
('Región de La Araucanía', 'Nueva Imperial'),
('Región de La Araucanía', 'Padre Las Casas'),
('Región de La Araucanía', 'Perquenco'),
('Región de La Araucanía', 'Pitrufquén'),
('Región de La Araucanía', 'Pucón'),
('Región de La Araucanía', 'Purén'),
('Región de La Araucanía', 'Renaico'),
('Región de La Araucanía', 'Saavedra'),
('Región de La Araucanía', 'Temuco'),
('Región de La Araucanía', 'Teodoro Schmidt'),
('Región de La Araucanía', 'Toltén'),
('Región de La Araucanía', 'Traiguén'),
('Región de La Araucanía', 'Victoria'),
('Región de La Araucanía', 'Vilcún'),
('Región de La Araucanía', 'Villarrica')

INSERT INTO location (city, district) VALUES 
('Región de Los Ríos', 'Corral'),
('Región de Los Ríos', 'Futrono'),
('Región de Los Ríos', 'Lago Ranco'),
('Región de Los Ríos', 'Lanco'),
('Región de Los Ríos', 'La Unión'),
('Región de Los Ríos', 'Los Lagos'),
('Región de Los Ríos', 'Máfil'),
('Región de Los Ríos', 'Mariquina'),
('Región de Los Ríos', 'Paillaco'),
('Región de Los Ríos', 'Panguipulli'),
('Región de Los Ríos', 'Río Bueno'),
('Región de Los Ríos', 'Valdivia'),

INSERT INTO location (city, district) VALUES 
('Región de Los Lagos', 'Ancud'),
('Región de Los Lagos', 'Calbuco'),
('Región de Los Lagos', 'Castro'),
('Región de Los Lagos', 'Chaitén'),
('Región de Los Lagos', 'Chonchi'),
('Región de Los Lagos', 'Cochamó'),
('Región de Los Lagos', 'Curauco de Vélez'),
('Región de Los Lagos', 'Dalcahue'),
('Región de Los Lagos', 'Fresia'),
('Región de Los Lagos', 'Frutillar'),
('Región de Los Lagos', 'Futaleufú'),
('Región de Los Lagos', 'Hualaihué'),
('Región de Los Lagos', 'Llanquihue'),
('Región de Los Lagos', 'Los Muermos'),
('Región de Los Lagos', 'Maullín'),
('Región de Los Lagos', 'Osorno'),
('Región de Los Lagos', 'Palena'),
('Región de Los Lagos', 'Puerto Montt'),
('Región de Los Lagos', 'Puerto Octay'),
('Región de Los Lagos', 'Puerto Varas'),
('Región de Los Lagos', 'Puqueldón'),
('Región de Los Lagos', 'Purranque'),
('Región de Los Lagos', 'Puyehue'),
('Región de Los Lagos', 'Queilén'),
('Región de Los Lagos', 'Quellón'),
('Región de Los Lagos', 'Quemchi'),
('Región de Los Lagos', 'Quinchao'),
('Región de Los Lagos', 'Río Negro'),
('Región de Los Lagos', 'San Juan de la Costa'),
('Región de Los Lagos', 'San Pablo')

INSERT INTO location (city, district) VALUES 
('Región Aysén del G. Carlos Ibáñez del Campo', 'Aysén'),
('Región Aysén del G. Carlos Ibáñez del Campo', 'Chile Chico'),
('Región Aysén del G. Carlos Ibáñez del Campo', 'Cisnes'),
('Región Aysén del G. Carlos Ibáñez del Campo', 'Cochrane'),
('Región Aysén del G. Carlos Ibáñez del Campo', 'Coyhaique'),
('Región Aysén del G. Carlos Ibáñez del Campo', 'Guaitecas'),
('Región Aysén del G. Carlos Ibáñez del Campo', 'Lago Verde'),
('Región Aysén del G. Carlos Ibáñez del Campo', 'Ohiggins'),
('Región Aysén del G. Carlos Ibáñez del Campo', 'Río Ibáñez'),
('Región Aysén del G. Carlos Ibáñez del Campo', 'Tortel')

INSERT INTO location (city, district) VALUES 
('Región de Magallanes y de la Antártica Chilena', 'Antártica'),
('Región de Magallanes y de la Antártica Chilena', 'Cabo de Hornos'),
('Región de Magallanes y de la Antártica Chilena', 'Laguna Blanca'),
('Región de Magallanes y de la Antártica Chilena', 'Natales'),
('Región de Magallanes y de la Antártica Chilena', 'Porvenir'),
('Región de Magallanes y de la Antártica Chilena', 'Primavera'),
('Región de Magallanes y de la Antártica Chilena', 'Punta Arenas'),
('Región de Magallanes y de la Antártica Chilena', 'Río Verde'),
('Región de Magallanes y de la Antártica Chilena', 'San Gregorio'),
('Región de Magallanes y de la Antártica Chilena', 'Timaukel'),
('Región de Magallanes y de la Antártica Chilena', 'Torres del Paine')

---INSERT USERS---
INSERT INTO users (name, email, password, linkedin, age, gender, description, created_at, type, modalidad, cdr, confirmation_hash, validated, metodo, city, profile_path, calendar) VALUES
('Thanya Casanova', 'thanyacasanovab@gmail.com', 'thanyacasanova', 'https://www.linkedin.com/in/thanyacasanova/?originalSubdomain=cl', '24', 'female', 'Soy psicóloga de la Universidad Diego Portales. Trabajo desde un enfoque psicoanalítico, integrando otras perspectivas y técnicas según las necesidades de cada paciente. Para mí, la terapia es un espacio seguro y confidencial donde no se juzga, y valoro profundamente la diversidad y subjetividad de cada persona. Reconozco que cada individuo tiene experiencias de vida únicas que moldean su perspectiva y manera de interactuar con el mundo. Estoy comprometida a acompañarte en tu proceso personal, ayudándote a explorar y entender tus sentimientos y experiencias. Mi objetivo es trabajar contigo para co-construir metas y estrategias que te guíen hacia el bienestar y el crecimiento personal.', '2024-07-26 18:18:48', '0', 'hybrid', '839258', '2D4BFC', '3', 'Psicología Clínica', 'REGIÓN METROPOLITANA DE SANTIAGO', '/img/therapist/foto_thanya.png', 'https://calendar.app.google/66mr5kDH1Ywc3cEv8'),
('Laura Martinez', 'Ps.lauramartinezf@gmail.com', 'lauramartinez', 'https://www.linkedin.com/in/laura-martinezf/', '24', 'female', 'Soy psicóloga clínica graduada de la Universidad Diego Portales. Tengo experiencia clínica en el COSAM Rinconada, donde realicé mi práctica profesional en el programa de tratamiento de adicciones. Actualmente, estoy realizando una estadía en terapia de familia y pareja en la UDP y un postítulo en la misma especialidad en la Universidad Alberto Hurtado (UAH). Mi enfoque es sistémico, y tengo experiencia en la aplicación de la prueba proyectiva Test de Rorschach. Me considero una persona abierta a escuchar y acompañar a cualquier persona que lo requiera, utilizando un enfoque que considera las relaciones y vínculos como ejes centrales del trabajo y del bienestar personal.', '2024-07-30 12:17:49', '0', 'hybrid', '836350', '4FD45C', '3', 'Psicología Clínica', 'REGIÓN METROPOLITANA DE SANTIAGO', '/img/therapist/foto_laura.png'),
('Isidora Schlesinger', 'Ps.i.schlesinger@gmail.com', 'isidoraschlesinger', 'https://www.linkedin.com/in/isidora-schlesinger-ramirez-701ab7202/', '24', 'female', 'Soy psicóloga clínica de la Universidad Diego Portales. Tengo un enfoque psicoanalítico y de género, sin embargo, creo que la terapia siempre debe adaptarse al paciente, por tanto, mis intervenciones siempre están centradas en las demandas particulares, trabajando a partir de la historia vital, priorizando la importancia del vínculo terapeútico, la ética y la integridad. Realicé mi práctica profesional en el Instituto Psiquiátrico Dr. José Horwitz Barak con pacientes de mediana y alta complejidad en atención abierta y cerrada. Hoy en día atiendo adolescentes, adultos y adultos mayores en clínica particular, modalidades online y presencial. Por otro lado, realizo evaluaciones psicodiagnósticas con Test de Rorschach, Test de Phillipson, entre otras. Si necesitas ayuda, cuenta conmigo!', '2024-07-30 12:24:20', '0', 'hybrid', '837350', 'FD87CF', '3', 'Psicología Clínica', 'REGIÓN METROPOLITANA DE SANTIAGO', '/img/therapist/foto_isi.png'),
('Williams Zamorano', 'zamoranowilliams.psi@gmail.com', 'williamszamorano', 'https://www.linkedin.com/in/williams-zamorano-coronado-005725318/?originalSubdomain=cl', '24', 'male', 'Soy psicólogo titulado de la Universidad Diego Portales, con formación sistémica, y atiendo tanto con niños, niñas y adolescentes como con adultos/as. Considero la terapia como un espacio seguro para trabajar en los objetivos que se co-construyan y así brindar la mejor experiencia posible para la persona, pudiendo colaborar en su bienestar emocional y subjetivo a través de un enfoque intercultural y de derechos. Realicé mi práctica profesional, además de trabajar por un tiempo, en Fundación Para la Confianza, específicamente en Línea Libre, por lo que cuento con experiencia en casos de vulneración de derechos de niños, niñas y adolescentes y diversas temáticas de salud mental y conflictos interpersonales.', '2024-07-30 13:15:06', '0', 'hybrid', '842807', '3297D5', '3', 'Psicología Clínica', 'REGIÓN METROPOLITANA DE SANTIAGO', '/img/therapist/foto_williams.png'),
('Antonia Saldias', 'antonia.saldias@mail.udp.cl', 'antoniasaldias', 'https://www.linkedin.com/in/antonia-sald%C3%ADas-de-mulder-a10411250/', '24', 'female', 'Soy psicóloga titulada de la Universidad Diego Portales. Poseo formación en la corriente cognitivo-conductual y atiendo a niños, niñas, adolescentes (NNA) y adultos/as. Además de esto, tengo conocimientos sobre el área de violencia de género, violencia intrafamiliar y vulneración de derechos de NNA los cuales he adquirido durante el transcurso de la carrera, mi práctica profesional y mi posterior especialización en el área. Considero que el espacio que cada persona puede otorgarse a sí misma dentro de terapia es fundamental para poder tratar diversas temáticas que puedan estar resonando en su vida. Trabajar a nivel psicológico puede contribuir a que la persona alivie su sufrimiento y mejore tanto su salud mental como su bienestar emocional.', '2024-07-31 13:58:00', '0', 'hybrid', '832169', '413BA0', '3', 'Psicología Clínica', 'REGIÓN METROPOLITANA DE SANTIAGO', '/img/therapist/foto_anto.png'),
('Walter Acuña', 'psi.walter@outlook.es', 'walteracuña', 'https://www.linkedin.com/in/walter-acu%C3%B1a-acu%C3%B1a-ba19a0261/', '24', 'male', 'Mi nombre es Walter Acuña, soy psicólogo titulado de la Universidad Diego Portales. realice mi formación en la corriente cognitivo-conductual, atiendo a adolescentes y adultos/as. La terapia psicológica permite abordar las problemáticas y malestares que nos afectan día a día, por lo que busco colaborar en los objetivos y las necesidades que se presentan en este espacio desde la colaboración para impactar en el bienestar del paciente, realizando un análisis funcional para adaptarse a cada individuo y a su contexto particular.', '2024-07-31 13:58:00', '0', 'hybrid', '836340', '85D56A', '3', 'Psicología Clínica', 'REGIÓN METROPOLITANA DE SANTIAGO', '/img/therapist/foto_walter.png'),
('Esperanza Mena', 'esperanzagabrielamena@gmail.com', 'esperanzamena', 'https://www.linkedin.com/in/esperanza-gabriela-mena-reyes-211b45303/', '24', 'female', 'Mi nombre es Esperanza Mena, psicóloga titulada de la Universidad Diego Portales. Presentó formación en clínica psicoanalítica infanto-adolescente. Además cuento con formación en intervenciones psicoterapéuticas breves. Por otro lado, poseo experiencia en la aplicación y evaluación de protocolo WISC-V, así como en evaluaciones proyectivas de la personalidad. La atención está pensada desde un enfoque de género y en determinantes sociales de la salud, comprendiendo que el malestar se ve afectado por factores psicosociales y materiales socioeconómicos que limitan el acceso a servicios de salud, y por lo tanto el acceso a tratamiento efectivo y a la recuperación.', '2024-08-01 19:10:32', '0', 'hybrid', '832158', 'DB8763', '3', 'Psicología Clínica', 'REGIÓN METROPOLITANA DE SANTIAGO', '/img/therapist/foto_esperanza.png')
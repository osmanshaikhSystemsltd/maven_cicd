SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

DELIMITER ;
--
-- Base de datos: `kumenya_matriculacion`
--
CREATE DATABASE kumenya_matriculacion DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE kumenya_matriculacion;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumnos`
--

DROP TABLE IF EXISTS `alumnos`;
CREATE TABLE IF NOT EXISTS `alumnos` (
  `Uid` bigint(16) unsigned zerofill NOT NULL default '0000000000000000',
  `NombreConyuge` varchar(50) default NULL,
  `NombrePadre` varchar(50) default NULL,
  `ProfesionPadre` varchar(50) default NULL,
  `NombreMadre` varchar(50) default NULL,
  `ProfesionMadre` varchar(50) default NULL,
  `CertificadoHomologado` enum('Si','No') default 'No',
  `EscuelaBachiller` varchar(100) default NULL,
  `RamaBachiller` varchar(50) default NULL,
  `ResultadoBachiller` varchar(50) default NULL,
  `AnioBachiller` year(4) default NULL,
  `DiplomaBachiller` enum('Si','No') default NULL,
  `EstudiosUniversitarios` enum('No','Si') default NULL,
  `UniversidadAnterior` varchar(100) default NULL,
  PRIMARY KEY  (`Uid`),
  KEY `rama_ind` (`RamaBachiller`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignaturas`
--

DROP TABLE IF EXISTS `asignaturas`;
CREATE TABLE IF NOT EXISTS `asignaturas` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `NombreAsignatura` varchar(100) NOT NULL,
  `Horas` int(5) NOT NULL default '45',
  `Vigente` bit(1) NOT NULL,
  `Tipo` enum('Troncal','Obligatoria','Optativa','Libre Eleccion') default NULL,
  `DuracionAsignatura` enum('Cuatrimestral','Semestral','Anual') default NULL,
  `Periodo` enum('primero','segundo','ninguno') default NULL,
  `Ponderacion` int(10) unsigned NOT NULL,
  `Curso` int(5) unsigned zerofill NOT NULL,
  `Departamento` varchar(100) NOT NULL,
  `Carrera` bigint(16) unsigned zerofill NOT NULL default '0000000000000001',
  `Facultad` bigint(16) unsigned zerofill default '0000000000000001',
  `Activo` bit(1) NOT NULL default '\0',
  `FechaCreacion` datetime NOT NULL,
  `FechaModificacion` datetime NOT NULL,
  `FechaBaja` datetime default NULL,
  PRIMARY KEY  (`Uid`),
  KEY `FK_asignaturas` (`Carrera`),
  KEY `FK_asignaturas_facultades` (`Facultad`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=773 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignaturasprofesores`
--

DROP TABLE IF EXISTS `asignaturasprofesores`;
CREATE TABLE IF NOT EXISTS `asignaturasprofesores` (
  `UidAsignatura` bigint(16) unsigned zerofill NOT NULL,
  `UidProfesor` bigint(16) unsigned zerofill NOT NULL,
  PRIMARY KEY  (`UidAsignatura`,`UidProfesor`),
  KEY `FK_AsignaturasProfesores_2` (`UidProfesor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carreras`
--

DROP TABLE IF EXISTS `carreras`;
CREATE TABLE IF NOT EXISTS `carreras` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Carrera` varchar(150) NOT NULL,
  `AniosCarrera` int(11) NOT NULL,
  `AniosPrimerCiclo` int(11) NOT NULL,
  `PrecioNacional` float(11,2) default NULL,
  `MonedaNacional` varchar(10) default 'FBU',
  `PrecioExtranjero` float(11,2) default NULL,
  `MonedaExtranjera` varchar(10) default 'USD',
  PRIMARY KEY  (`Uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clavesexternas`
--

DROP TABLE IF EXISTS `clavesexternas`;
CREATE TABLE IF NOT EXISTS `clavesexternas` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Tabla` varchar(45) NOT NULL,
  `Columna` varchar(45) NOT NULL,
  `TablaReferencia` varchar(45) NOT NULL,
  `Clave` varchar(45) NOT NULL,
  `Valor` varchar(45) NOT NULL,
  `Ambito` varchar(45) NOT NULL,
  `Buscar` enum('YES','NO') NOT NULL default 'NO',
  PRIMARY KEY  (`Uid`),
  UNIQUE KEY `UnicaClaveExterna` USING BTREE (`Tabla`,`Columna`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facultades`
--

DROP TABLE IF EXISTS `facultades`;
CREATE TABLE IF NOT EXISTS `facultades` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Facultad` varchar(150) NOT NULL,
  PRIMARY KEY  (`Uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `licenciados`
--

DROP TABLE IF EXISTS `licenciados`;
CREATE TABLE IF NOT EXISTS `licenciados` (
  `Uid` bigint(16) NOT NULL,
  `NombreApellidos` varchar(100) NOT NULL,
  `NumIdentificacion` varchar(20) NOT NULL,
  `Anio` int(5) NOT NULL,
  `NombreAsignatura` varchar(150) NOT NULL,
  `Curso` int(5) NOT NULL,
  `Carrera` varchar(150) NOT NULL,
  `Nota` float(11,0) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `localidades`
--

DROP TABLE IF EXISTS `localidades`;
CREATE TABLE IF NOT EXISTS `localidades` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Localidad` varchar(100) NOT NULL,
  PRIMARY KEY  (`Uid`),
  KEY `Ind_Localidad` (`Localidad`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=433 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `matriculas`
--

DROP TABLE IF EXISTS `matriculas`;
CREATE TABLE IF NOT EXISTS `matriculas` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `UidAlumno` bigint(16) unsigned zerofill NOT NULL,
  `Anio` int(10) unsigned NOT NULL,
  `DocumentacionCompleta` bit(1) default '',
  `BecaGobierno` varchar(6) default NULL,
  `Observaciones` varchar(400) default NULL,
  `Convalidada` bit(1) NOT NULL default '\0',
  `Porcentaje` float(11,2) default NULL,
  `Mencion` varchar(90) default NULL,
  `Activo` bit(1) NOT NULL default '',
  `FechaCreacion` datetime NOT NULL,
  `FechaModificacion` datetime NOT NULL,
  `FechaBaja` datetime default NULL,
  PRIMARY KEY  (`Uid`,`UidAlumno`,`Anio`),
  KEY `FK_matriculas_1` (`UidAlumno`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1421 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `matriculasasignaturas`
--

DROP TABLE IF EXISTS `matriculasasignaturas`;
CREATE TABLE IF NOT EXISTS `matriculasasignaturas` (
  `UidMatricula` bigint(16) unsigned zerofill NOT NULL,
  `UidAsignatura` bigint(16) unsigned zerofill NOT NULL,
  `SesionPrimera` varchar(50) NOT NULL default 'febrero',
  `NotaPrimera` float(11,2) default NULL,
  `SesionSegunda` varchar(50) NOT NULL default 'junio',
  `NotaSegunda` float(11,2) default NULL,
  `SesionExtraordinaria` varchar(50) default NULL,
  `NotaExtraordinaria` float(11,2) default NULL,
  `NotaFinal` float(11,2) default NULL,
  `Activo` bit(1) NOT NULL default '',
  `FechaCreacion` datetime NOT NULL,
  `FechaModificacion` datetime NOT NULL,
  `FechaBaja` datetime default NULL,
  PRIMARY KEY  (`UidMatricula`,`UidAsignatura`),
  KEY `FK_matriculasasignaturas_2` (`UidAsignatura`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `matriculaspendientes`
--

DROP TABLE IF EXISTS `matriculaspendientes`;
CREATE TABLE IF NOT EXISTS `matriculaspendientes` (
  `Identificacion` varchar(20) NOT NULL,
  `Codigo` varchar(10) NOT NULL,
  PRIMARY KEY  (`Identificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `meses`
--

DROP TABLE IF EXISTS `meses`;
CREATE TABLE IF NOT EXISTS `meses` (
  `Uid` int(11) NOT NULL,
  `Mes` varchar(50) NOT NULL,
  PRIMARY KEY  (`Uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paises`
--

DROP TABLE IF EXISTS `paises`;
CREATE TABLE IF NOT EXISTS `paises` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Pais` varchar(150) NOT NULL,
  PRIMARY KEY  (`Uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parametros`
--

DROP TABLE IF EXISTS `parametros`;
CREATE TABLE IF NOT EXISTS `parametros` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Nombre` varchar(100) NOT NULL,
  `Orden` int(10) unsigned NOT NULL,
  `UidProc` bigint(16) unsigned NOT NULL,
  `Tipo` enum('IN','OUT','INOUT') NOT NULL,
  `TipoDatos` varchar(100) default NULL,
  `ConsultaQuery` varchar(500) default NULL,
  PRIMARY KEY  (`Uid`),
  UNIQUE KEY `ParametroUnico` (`Nombre`,`UidProc`),
  UNIQUE KEY `OrdenUnico` USING BTREE (`Orden`,`UidProc`),
  KEY `FK_parametros_procedimientos` (`UidProc`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=990 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pas`
--

DROP TABLE IF EXISTS `pas`;
CREATE TABLE IF NOT EXISTS `pas` (
  `Uid` bigint(16) unsigned zerofill NOT NULL,
  `Estudios` varchar(50) default NULL,
  `Experiencia` int(5) default NULL,
  PRIMARY KEY  (`Uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

DROP TABLE IF EXISTS `personas`;
CREATE TABLE IF NOT EXISTS `personas` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Nombre` varchar(50) NOT NULL COMMENT 'Prueba para la kumenya_matriculacion',
  `Apellidos` varchar(50) NOT NULL,
  `CodigoPersona` varchar(10) NOT NULL,
  `TipoPersona` enum('Alumno','PAS','Profesor') character set utf8 NOT NULL default 'Alumno',
  `NumIdentificacion` varchar(20) NOT NULL,
  `FechaNacimiento` date default NULL,
  `LugarNacimiento` varchar(100) default NULL,
  `Direccion` varchar(200) default NULL,
  `Distrito` varchar(100) default NULL,
  `Localidad` bigint(16) unsigned zerofill NOT NULL default '0000000000000001',
  `Provincia` bigint(16) unsigned zerofill NOT NULL,
  `Pais` bigint(16) unsigned zerofill NOT NULL,
  `Sexo` enum('Mujer','Hombre') character set utf8 NOT NULL default 'Hombre',
  `EstadoCivil` enum('Soltero','Casado','Viudo','Separado','Divorciado') character set utf8 default 'Soltero',
  `Observaciones` varchar(600) default NULL,
  `Activo` bit(1) NOT NULL default '',
  `FechaCreacion` datetime NOT NULL,
  `FechaModificacion` datetime NOT NULL,
  `FechaBaja` datetime default NULL,
  PRIMARY KEY  (`Uid`),
  KEY `FK_loc_persona` (`Localidad`),
  KEY `FK_prov_persona` (`Provincia`),
  KEY `FK_pai_persona` (`Pais`),
  KEY `In_Identidad` (`NumIdentificacion`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1563 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `procedimientos`
--

DROP TABLE IF EXISTS `procedimientos`;
CREATE TABLE IF NOT EXISTS `procedimientos` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Nombre` varchar(100) character set latin1 NOT NULL,
  PRIMARY KEY  (`Uid`),
  UNIQUE KEY `NombreUnico` (`Nombre`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=157 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesores`
--

DROP TABLE IF EXISTS `profesores`;
CREATE TABLE IF NOT EXISTS `profesores` (
  `Uid` bigint(16) unsigned zerofill NOT NULL,
  `Especialidad` varchar(50) default NULL,
  `Visitante` bit(1) NOT NULL,
  PRIMARY KEY  (`Uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provincias`
--

DROP TABLE IF EXISTS `provincias`;
CREATE TABLE IF NOT EXISTS `provincias` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Provincia` varchar(150) NOT NULL,
  PRIMARY KEY  (`Uid`),
  KEY `Index_provincia` (`Provincia`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 10240 kB' AUTO_INCREMENT=59 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ramas`
--

DROP TABLE IF EXISTS `ramas`;
CREATE TABLE IF NOT EXISTS `ramas` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Rama` varchar(150) NOT NULL,
  PRIMARY KEY  (`Uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Filtros para las tablas descargadas (dump)
--

--
-- Filtros para la tabla `alumnos`
--
ALTER TABLE `alumnos`
  ADD CONSTRAINT `FK_alumnos_personas` FOREIGN KEY (`Uid`) REFERENCES `personas` (`Uid`);

--
-- Filtros para la tabla `asignaturas`
--
ALTER TABLE `asignaturas`
  ADD CONSTRAINT `FK_asignaturas` FOREIGN KEY (`Carrera`) REFERENCES `carreras` (`Uid`),
  ADD CONSTRAINT `FK_asignaturas_facultades` FOREIGN KEY (`Facultad`) REFERENCES `facultades` (`Uid`);

--
-- Filtros para la tabla `asignaturasprofesores`
--
ALTER TABLE `asignaturasprofesores`
  ADD CONSTRAINT `FK_AsignaturasProfesores_1` FOREIGN KEY (`UidAsignatura`) REFERENCES `asignaturas` (`Uid`),
  ADD CONSTRAINT `FK_AsignaturasProfesores_2` FOREIGN KEY (`UidProfesor`) REFERENCES `profesores` (`Uid`);

--
-- Filtros para la tabla `matriculas`
--
ALTER TABLE `matriculas`
  ADD CONSTRAINT `FK_matriculas_1` FOREIGN KEY (`UidAlumno`) REFERENCES `alumnos` (`Uid`);

--
-- Filtros para la tabla `matriculasasignaturas`
--
ALTER TABLE `matriculasasignaturas`
  ADD CONSTRAINT `FK_matriculasasignaturas_2` FOREIGN KEY (`UidAsignatura`) REFERENCES `asignaturas` (`Uid`),
  ADD CONSTRAINT `matriculasasignaturas_ibfk_1` FOREIGN KEY (`UidMatricula`) REFERENCES `matriculas` (`Uid`);

--
-- Filtros para la tabla `parametros`
--
ALTER TABLE `parametros`
  ADD CONSTRAINT `FK_parametros_procedimientos` FOREIGN KEY (`UidProc`) REFERENCES `procedimientos` (`Uid`);

--
-- Filtros para la tabla `pas`
--
ALTER TABLE `pas`
  ADD CONSTRAINT `FK_pas_personas` FOREIGN KEY (`Uid`) REFERENCES `personas` (`Uid`);

--
-- Filtros para la tabla `personas`
--
ALTER TABLE `personas`
  ADD CONSTRAINT `FK_loc_persona` FOREIGN KEY (`Localidad`) REFERENCES `localidades` (`Uid`),
  ADD CONSTRAINT `FK_pai_persona` FOREIGN KEY (`Pais`) REFERENCES `paises` (`Uid`),
  ADD CONSTRAINT `FK_prov_persona` FOREIGN KEY (`Provincia`) REFERENCES `provincias` (`Uid`);

--
-- Filtros para la tabla `profesores`
--
ALTER TABLE `profesores`
  ADD CONSTRAINT `FK_profesores_personas` FOREIGN KEY (`Uid`) REFERENCES `personas` (`Uid`);

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `ActivarAlumno`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActivarAlumno`(Identi varchar(20), out exito int(11), out salida varchar(100), out codigo varchar(10))
BEGIN
	START TRANSACTION;
	if ((select count(*) from personas where NumIdentificacion = Identi) > 0) then
		set @codigo = (select CodigoPersona from personas where NumIdentificacion = Identi);
		if (mid(@codigo,1,1) = 'E') then
			set @exito = 0;
			set @salida = 'La persona a activar ya es alumno';
		else
			if ((select count(*) from matriculaspendientes where Identificacion = Identi) > 0) then
				set @exito = 0;
				set @salida = 'La persona está pendiente de matriculación';
			else
				set @codigo=SiguienteCodigo('Alumno');
				insert into matriculaspendientes (Identificacion, Codigo) values (Identi, @codigo);
				set @exito = 1;
				set @salida = 'Alumno preparado para la matriculación';
			end if;
		end if;
	else
		if ((select count(*) from matriculaspendientes where Identificacion = Identi) > 0) then
			set @exito = 0;
			set @salida = 'La persona está pendiente de matriculación';
		else
			set @codigo=SiguienteCodigo('Alumno');
			insert into matriculaspendientes (Identificacion, Codigo) values (Identi, @codigo);
			set @exito = 1;
			set @salida = 'Alumno preparado para la matriculación';
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida, @codigo;
END$$

DROP PROCEDURE IF EXISTS `AltaDarAsignaturaProfesor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDarAsignaturaProfesor`(UidAsig bigint(16), UidProf bigint(16), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	if (select count(*) from asignaturasprofesores where UidAsignatura = UidAsig and UidProfesor = UidProf) = 0 then
			insert into asignaturasprofesores value (UidAsig, UidProf);
			set @exito = 1;
			set @salida =  'Se ha creado el registro';
	else
		set @exito = 0;
		set @salida =  'No se ha creado el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `AltaDeAlumno`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeAlumno`(Nombr varchar(50), Apellid varchar(50), CodPer varchar(10), TipoPer enum ('Alumno','PAS','Profesor'),NumId varchar(20), Observ varchar(600), FechaNac varchar(10),LugarNac varchar(100), Dir varchar(200), Distr varchar(100), Loca int, Prov int, Pai int, Sex enum('Mujer','Hombre'), EstadoCiv enum('Soltero','Casado','Viudo','Separado','Divorciado'), NombreCony varchar(50), NombrePa varchar(50), ProfesionPa varchar(50), NombreMa varchar(50), ProfesionMa varchar(50), CertificadoHomo enum('Si','No'), EscuelaBach varchar(100), RamaBach int, ResultadoBach varchar(100), AnioBach varchar(10), DiplomaBach enum('Si','No'), EstudiosUni enum('Si','No'), UniversidadAnt varchar(100), OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	if isnull(concat(Nombr,Apellid,CodPer,TipoPer,NumId))=1 then
		set @exito = 0;
		set @salida = ValidarNullAltaPersona(Nombr,Apellid,CodPer,TipoPer,NumId);
	else
		if  (select count(*) from personas where  NumIdentificacion= NumId) > 0 then
			set @salida = 'Número de identificación ya existente';
			set @exito = 0;
		else
			if TipoPer <> 'Alumno' then
				set @salida = 'El tipo de persona debe ser Alumno';
				set @exito = 0;
			else
				if ((select Codigo from matriculaspendientes where Identificacion = NumId) <> CodPer) then
					set @salida = 'No puede modificar el código de la persona';
					set @exito = 0;
				else
					if (select count(*) from personas where CodigoPersona = CodPer) > 0 then
						set @salida = 'Código de persona ya existente';
						set @exito = 0;
					else
						if (select Identificacion from matriculaspendientes where Codigo = CodPer) <> NumId then
							set @salida = 'No puede modificar el número de identificación';
							set @exito = 0;
						else
							call AltaDePersona(Nombr,Apellid,CodPer,TipoPer,NumId,Observ, FechaNac,LugarNac,Dir,Distr,Loca,Prov,Pai,Sex,EstadoCiv);
							SET @Uid = LAST_INSERT_ID();
							INSERT INTO alumnos
								(Uid,NombreConyuge, NombrePadre, ProfesionPadre, NombreMadre, ProfesionMadre, CertificadoHomologado, EscuelaBachiller, RamaBachiller, ResultadoBachiller, AnioBachiller, DiplomaBachiller, EstudiosUniversitarios, UniversidadAnterior)
							VALUES
								(@Uid,NombreCony, NombrePa, ProfesionPa, NombreMa, ProfesionMa, CertificadoHomo, EscuelaBach,  RamaBach, ResultadoBach, AnioBach, DiplomaBach, EstudiosUni, UniversidadAnt);
							delete from matriculaspendientes where Identificacion = NumId;
							set @cuenta = SiguienteCuenta('Alumno', 'No');
							set @papi = (select Uid from kumenya_contabilidad.cuentascontables where NumeroCuenta = mid(@cuenta,1,4) and Activo =1);
							set @clase = (select Uid from kumenya_contabilidad.clases where NumeroClase = mid(@cuenta,1,1));
							if not isnull(@papi) then
								insert into kumenya_contabilidad.cuentascontables
									(UidClase, UidTercero, TipoCuenta, NumeroCuenta, NombreCuenta, Debe, Haber, Padre, TipoTercero, Activo, FechaCreacion, FechaModificacion)
								values
									(@clase, @Uid, 'Activo', @cuenta, concat(Apellid,' ', Nombr), 0, 0, @papi, 'Persona', 1, now(), now());
								set @salida = 'Se ha creado el registro';
								set @exito = 1;
							else
								set @exito = 0;
								set @salida = 'Cuenta padre inactiva o inexistente';
							end if;
						end if;
					end if;
				end if;
			end if;
		end if;
	end if;

	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `AltaDeAsignatura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeAsignatura`(asig varchar(150), hor int, tip enum('Troncal','Obligatoria','Optativa','Libre Eleccion'), dur enum('Cuatrimestral','Semestral','Anual'), per enum('primero','segundo','ninguno'), cur int(5), depart varchar(150), car bigint(16), fac bigint(16), pond int(5), vig enum('Si','No'), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	set @exito = 0;
	if isnull(concat(asig,cur, depart, car,vig, pond)) then
		set @salida = ValidarNullAltaAsignatura(asig,cur, depart, car,vig,pond);
	else
		if !(dur = 'Anual' xor per = 'ninguno') and (cur <= (select kumenya_biblioteca.configuracion.Valor from kumenya_biblioteca.configuracion where kumenya_biblioteca.configuracion.NombreAtributo='MaximoAniosCarrera')) then
			insert into asignaturas (NombreAsignatura, Horas, Tipo, DuracionAsignatura, Periodo, Curso, Departamento, Carrera, Facultad, Ponderacion, Vigente, Activo, FechaCreacion,FechaModificacion) value
			(asig, hor, tip, dur, per, cur, depart, car, fac, pond, vig, 1, now(), now());
			set @exito = 1;
			set @salida = 'Se ha creado el registro';
		else
			if (cur > (select kumenya_biblioteca.configuracion.Valor from kumenya_biblioteca.configuracion where kumenya_biblioteca.configuracion.NombreAtributo='MaximoAniosCarrera')) then
				set @salida= 'No es un curso válido';
			else
				set @salida = 'La duración de la asignatura es incoherente con el periodo de la misma';
			end if;
		end if;
	end if;

	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `AltaDeCarrera`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeCarrera`(carrier varchar(150), aniosCar int, aniosCiclo int, out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	if (select count(*) from carreras where Carrera = carrier) = 0 then
		insert into carreras (Carrera, AniosCarrera, AniosPrimerCiclo) value (carrier, aniosCar, aniosCiclo);
		set @exito = 1;
		set @salida = 'Se ha creado el registro';
	else
		set @exito = 0;
		set @salida = 'No se ha creado el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `AltaDeFacultad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeFacultad`(fac varchar(150), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	if (select count(*) from facultades where Facultad = fac) = 0 then
		insert into facultades (Facultad) value (fac);
		set @exito = 1;
		set @salida = 'Se ha creado el registro';
	else
		set @exito = 0;
		set @salida = 'No se ha creado el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `AltaDeLocalidad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeLocalidad`(loc varchar(150), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	if (select count(*) from localidades where Localidad=loc) = 0 then
		insert into localidades (Localidad) value (loc);
		set @exito = 1;
		set @salida = 'Se ha creado el registro';
	else
		set @exito = 0;
		set @salida = 'No se ha creado el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `AltaDeMatricula`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeMatricula`(UidAlum bigint(16), Doc bit, Beca varchar(6), Obs varchar(400), OUT exito  int(11), OUT salida int(11))
begin
	START TRANSACTION;
	if (select count(*) from matriculas where UidAlumno= UidAlum and Anio >= year(convert((select Valor from kumenya_biblioteca.configuracion where NombreAtributo='FechaInicioCurso'), date)) and Activo = 1) = 0 then
		insert into matriculas(UidAlumno, Anio,DocumentacionCompleta, BecaGobierno, Observaciones, Activo, FechaCreacion,FechaModificacion)
			value (UidAlum,year(convert((select Valor from kumenya_biblioteca.configuracion where NombreAtributo='FechaInicioCurso'), date)) ,Doc, Beca, Obs,1,now(),now());
		set @exito = 1;
		set @salida =  'Se ha creado el registro';
	else
		set @exito = 0;
		set @salida =  'No se ha creado el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `AltaDeMatriculaAsignatura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeMatriculaAsignatura`(UidMat bigint(16), UidAsig bigint(16), OUT exito  int(11), OUT salida int(11))
begin
	START TRANSACTION;
	if (select count(*) from matriculasasignaturas where UidMatricula = UidMat and UidAsignatura = UidAsig) = 0 then
		insert into matriculasasignaturas (UidMatricula, UidAsignatura, SesionPrimera, SesionSegunda, SesionExtraordinaria, Activo, FechaCreacion, FechaModificacion) values
		(UidMat, UidAsig, (select Valor from kumenya_biblioteca.configuracion where NombreAtributo='SesionPrimera'),
					     (select Valor from kumenya_biblioteca.configuracion where NombreAtributo='SesionSegunda'),
					     (select Valor from kumenya_biblioteca.configuracion where NombreAtributo='SesionExtraordinaria'), 1, now(), now());
		set @exito = 1;
		set @salida = 'Se ha creado el registro';
	else
		set @exito = 0;
		set @salida = 'No se ha creado el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `AltaDePais`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDePais`(country varchar(150), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	if (select count(*) from paises where Pais=country) = 0 then
		insert into paises (Pais) value (country);
		set @exito = 1;
		set @salida = 'Se ha creado el registro';
	else
		set @exito = 0;
		set @salida = 'No se ha creado el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `AltaDePas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDePas`(Nombr varchar(50), Apellid varchar(50), CodPer varchar(10), TipoPer enum ('Alumno','PAS','Profesor'),NumId varchar(20), Observ varchar(600), FechaNac varchar(10), LugarNac varchar(100), Dir varchar(200), Distr varchar(100), Loca int, Prov int, Pai int, Sex enum('Mujer','Hombre'), EstadoCiv enum('Soltero','Casado','Viudo','Separado','Divorciado'), Estud varchar(50), Exper int(5), OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	set CodPer = 'a';
	if isnull(concat(Nombr,Apellid,CodPer,TipoPer,NumId))=1 then
		set @exito = 0;
		set @salida = ValidarNullAltaPersona(Nombr,Apellid,CodPer,TipoPer,NumId);
	else
		if  (select count(*) from personas where  NumIdentificacion= NumId) > 0 then
			set @salida = 'Número de identificación ya existente';
			set @exito = 0;
		else
			if TipoPer <> 'PAS' then
				set @salida = 'El tipo de persona debe ser PAS';
				set @exito = 0;
			else
				set @codigo = SiguienteCodigo(TipoPer);
				call AltaDePersona(Nombr,Apellid,@codigo,TipoPer,NumId,Observ,FechaNac,LugarNac,Dir,Distr,Loca,Prov,Pai,Sex,EstadoCiv);
				SET @Uid = LAST_INSERT_ID();
				INSERT INTO pas
					(Uid,Estudios, Experiencia)
				VALUES
					(@Uid,Estud, Exper);
				set @cuenta = SiguienteCuenta('PAS','No');
				set @papi = (select Uid from kumenya_contabilidad.cuentascontables where NumeroCuenta = mid(@cuenta,1,4) and Activo = 1);
				set @clase = (select Uid from kumenya_contabilidad.clases where NumeroClase = mid(@cuenta,1,1));
				if not isnull(@papi) then
					insert into kumenya_contabilidad.cuentascontables
						(UidClase, UidTercero, TipoCuenta, NumeroCuenta, NombreCuenta, Debe, Haber, Padre, TipoTercero, Activo, FechaCreacion, FechaModificacion)
					values
						(@clase, @Uid, 'Pasivo', @cuenta, concat(Apellid,' ',Nombr), 0, 0, @papi, 'Persona', 1, now(), now());
					set @salida = 'Se ha creado el registro';
					set @exito = 1;
				else
					set @exito = 0;
					set @salida = 'Cuenta padre inactiva o inexistente';
				end if;
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `AltaDePersona`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDePersona`(Nombr varchar(50), Apellid varchar(50), CodPer varchar(10), TipoPer enum ('Alumno','PAS','Profesor'),NumId varchar(20), Observ varchar(600), FechaNac varchar(10), LugarNac varchar(100), Dir varchar(200), Distr varchar(100), Loca int, Prov int, Pai int, Sex enum('Mujer','Hombre'), EstadoCiv enum('Soltero','Casado','Viudo','Separado','Divorciado'))
BEGIN
	INSERT INTO personas (Nombre, Apellidos, CodigoPersona, TipoPersona, NumIdentificacion, Observaciones, FechaNacimiento,LugarNacimiento, Direccion, Distrito, Localidad, Provincia, Pais, Sexo, EstadoCivil, Activo, FechaCreacion, FechaModificacion) VALUES (Nombr, Apellid, CodPer, TipoPer, NumId, Observ, FechaNac, LugarNac, Dir, Distr, Loca, Prov, Pai, Sex, EstadoCiv,1, NOW(), NOW());
END$$

DROP PROCEDURE IF EXISTS `AltaDeProfesor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeProfesor`(Nombr varchar(50), Apellid varchar(50), CodPer varchar(10), TipoPer enum ('Alumno','PAS','Profesor'),NumId varchar(20), Observ varchar(600), FechaNac varchar(10), LugarNac varchar(100), Dir varchar(200), Distr varchar(100),Loca int, Prov int, Pai int, Sex enum('Mujer','Hombre'), EstadoCiv enum('Soltero','Casado','Viudo','Separado','Divorciado'), Espec varchar(50), Visita enum('No','Si'), OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	set CodPer = ' ';
	if isnull(concat(Nombr,Apellid,CodPer,TipoPer,NumId))=1 then
		set @exito = 0;
		set @salida = ValidarNullAltaPersona(Nombr,Apellid,CodPer,TipoPer,NumId);
	else
		if  (select count(*) from personas where  NumIdentificacion= NumId) > 0 then
			set @salida = 'Número de identificación ya existente';
			set @exito = 0;
		else
			if TipoPer <> 'Profesor' then
				set @salida = 'El tipo de persona debe ser Profesor';
				set @exito = 0;
			else
				if isnull(Visita) then
					set @exito = 0;
					set @salida = 'El campo Visitante es obligatorio';
				else
					set @codigo = SiguienteCodigo(TipoPer);
					call AltaDePersona(Nombr,Apellid,@codigo,TipoPer,NumId,Observ,FechaNac,LugarNac,Dir,Distr,Loca,Prov,Pai,Sex,EstadoCiv);
					SET @Uid = LAST_INSERT_ID();
					INSERT INTO profesores
						(Uid,Especialidad,Visitante)
					VALUES
						(@Uid,Espec, Visita);
					set @cuenta = SiguienteCuenta('Profesor',Visita);
					set @papi = (select Uid from kumenya_contabilidad.cuentascontables where NumeroCuenta = mid(@cuenta,1,4) and Activo =1);
					set @clase = (select Uid from kumenya_contabilidad.clases where NumeroClase = mid(@cuenta,1,1));
					if not isnull(@papi) then
						insert into kumenya_contabilidad.cuentascontables
							(UidClase, UidTercero, TipoCuenta, NumeroCuenta, NombreCuenta, Debe, Haber, Padre, TipoTercero, Activo, FechaCreacion, FechaModificacion)
						values
							(@clase, @Uid, 'Pasivo', @cuenta, concat(Apellid,' ', Nombr), 0, 0, @papi, 'Persona', 1, now(), now());
						set @salida = 'Se ha creado el registro';
						set @exito = 1;
					else
						set @exito = 0;
						set @salida = 'Cuenta padre inactiva o inexistente';
					end if;
				end if;
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `AltaDeProvincia`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeProvincia`(prov varchar(150), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	if (select count(*) from provincias where Provincia=prov) = 0 then
		insert into provincias (Provincia) value (prov);
		set @exito = 1;
		set @salida = 'Se ha creado el registro';
	else
		set @exito = 0;
		set @salida = 'No se ha creado el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `AltaDeRama`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeRama`(branch varchar(150), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	if (select count(*) from ramas where Rama=branch) = 0 then
		insert into ramas (Rama) value (branch);
		set @exito = 1;
		set @salida = 'Se ha creado el registro';
	else
		set @exito = 0;
		set @salida = 'No se ha creado el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `AltaMatriculaConvalidacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaMatriculaConvalidacion`(IdStudent bigint(16), RegistrYear int(5), Observ varchar(400), out success int(11), out message varchar(50), out registr bigint(16))
begin

	if RegistrYear = (select year(Valor) from kumenya_biblioteca.configuracion where NombreAtributo = 'FechaInicioCurso') then
		set @success = 0;
		set @message = 'El año tiene que ser anterior al actual';
	else
		insert into matriculas(UidAlumno, Anio, DocumentacionCompleta, BecaGobierno, Observaciones, Convalidada, Activo, FechaCreacion, FechaModificacion) values (IdStudent, RegistrYear, 1, null, Observ, 1, 1, now(), now());
		set @regist = last_insert_id();
		set @message = 'Se ha creado el registro';
		set @success = 1;
	end if;
	select @success, @message, @regist;

end$$

DROP PROCEDURE IF EXISTS `AltaNota`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaNota`(UidAsig bigint(16), UidMat bigint(16), nota1 float(11,2), nota2 float(11,2), nota3 float(11,2), nota4 float(11,2), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
		set @exito = 0;
		set @salida =  'No se ha creado el registro';
	update matriculasasignaturas set NotaPrimera= nota1 where UidAsignatura = UidAsig and UidMatricula = UidMat and Activo = 1;
	update matriculasasignaturas set NotaSegunda= nota2 where UidAsignatura = UidAsig and UidMatricula = UidMat and Activo = 1;
	update matriculasasignaturas set NotaExtraordinaria= nota3 where UidAsignatura = UidAsig and UidMatricula = UidMat and Activo = 1;
	update matriculasasignaturas set NotaFinal= nota4 where UidAsignatura = UidAsig and UidMatricula = UidMat and Activo = 1;
	set @exito = 1;
	set @salida =  'Se ha creado el registro';
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `AMatricular`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AMatricular`(Ident varchar(20), Codi varchar(10), out exito int(11), out salida varchar(20), out id varchar(20), out co varchar(10))
BEGIN
	START TRANSACTION;
	if (Ident is null) and (Codi is null) then
		set @exito = 0;
		set @salida = 'Tiene que rellenar algún criterio de búsqueda';
		set @id = 0;
		set @co = 0;
	else
		if (Ident is null) then
			set @id = (select Identificacion from matriculaspendientes where Codigo = Codi);
			set @co = (select Codigo from matriculaspendientes where Codigo = Codi);
			if (@id is null) and (@co is null) then
				set @exito = 0;
				set @salida = 'El alumno no existe en la base de datos. Tiene que registrarse en contabilidad';
			else
				if ((@id is null) and (@co is not null)) or ((@id is not null) and (@co is null)) then
					set @exito = 0;
					set @salida = 'Registro incompleto. Hablar con contabilidad';
				else
					set @exito = 1;
					set @salida = 'Búsqueda satisfactoria';
				end if;
			end if;
		else
			set @id = (select Identificacion from matriculaspendientes where Identificacion = Ident);
			set @co = (select Codigo from matriculaspendientes where Identificacion = Ident);
			if (@id is null) and (@co is null) then
				set @exito = 0;
				set @salida = 'El alumno no existe en la base de datos. Tiene que registrarse en contabilidad';
			else
				if ((@id is null) and (@co is not null)) or ((@id is not null) and (@co is null)) then
					set @exito = 0;
					set @salida = 'Registro incompleto. Hablar con contabilidad';
				else
					set @exito = 1;
					set @salida = 'Búsqueda satisfactoria';
				end if;
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida,@id,@co;
END$$

DROP PROCEDURE IF EXISTS `ANUALTEMP`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ANUALTEMP`()
begin
	START TRANSACTION;
	set @exito = 0;
insert into licenciados  
select concat(personas.Nombre, ' ', personas.Apellidos) as persona, personas.NumIdentificacion,matriculas.Anio, NombreAsignatura, Curso, carreras.Carrera, round(NotaFinal,2)
	from asignaturas, matriculasasignaturas, matriculas ,personas, carreras
	where asignaturas.Uid = matriculasasignaturas.UidAsignatura and matriculas.Uid = matriculasasignaturas.UidMatricula
			and matriculas.UidAlumno = personas.Uid and asignaturas.Carrera = carreras.Uid
			and matriculasasignaturas.UidMatricula in (select Uid from matriculas  where Activo = 1);
delete from licenciados where NumIdentificacion not in
(
select distinct(NumIdentificacion)
from
	asignaturas,
	(select NumIdentificacion, carrera, count(NumIdentificacion) as total
		from licenciados
		where NombreAsignatura in (select asignaturas.NombreAsignatura from asignaturas where asignaturas.Carrera = (select Uid from carreras where carreras.Carrera = licenciados.Carrera)) and Nota >= 5.0
		group by NumIdentificacion
	) as temp
where (select count(1) from asignaturas where carrera = (select Uid from carreras where carreras.Carrera = temp.carrera)) = temp.total
);
delete from matriculasasignaturas where UidMatricula in (select Uid from matriculas where UidAlumno in (select Uid from personas where NumIdentificacion in
										(
											select distinct(NumIdentificacion)
											from asignaturas,
												(select NumIdentificacion, carrera, count(NumIdentificacion) as total
													from licenciados
													where NombreAsignatura in (select asignaturas.NombreAsignatura from asignaturas where asignaturas.Carrera = (select Uid from carreras where carreras.Carrera = licenciados.Carrera)) and Nota >= 5.0
													group by NumIdentificacion
												) as temp
											where (select count(1) from asignaturas where carrera = (select Uid from carreras where carreras.Carrera = temp.carrera)) = temp.total
										)
									)
											);
delete from matriculas where UidAlumno in (select Uid from personas where NumIdentificacion in
										(
											select distinct(NumIdentificacion)
											from asignaturas,
												(select NumIdentificacion, carrera, count(NumIdentificacion) as total
													from licenciados
													where NombreAsignatura in (select asignaturas.NombreAsignatura from asignaturas where asignaturas.Carrera = (select Uid from carreras where carreras.Carrera = licenciados.Carrera)) and Nota >= 5.0
													group by NumIdentificacion
												) as temp
											where (select count(1) from asignaturas where carrera = (select Uid from carreras where carreras.Carrera = temp.carrera)) = temp.total
										)
									);
delete from alumnos where Uid in (select Uid from personas where NumIdentificacion in
										(
											select distinct(NumIdentificacion)
											from asignaturas,
												(select NumIdentificacion, carrera, count(NumIdentificacion) as total
													from licenciados
													where NombreAsignatura in (select asignaturas.NombreAsignatura from asignaturas where asignaturas.Carrera = (select Uid from carreras where carreras.Carrera = licenciados.Carrera)) and Nota >= 5.0
													group by NumIdentificacion
												) as temp
											where (select count(1) from asignaturas where carrera = (select Uid from carreras where carreras.Carrera = temp.carrera)) = temp.total
										)
									);
delete from personas where NumIdentificacion in
(
select distinct(NumIdentificacion)
from
	asignaturas,
	(select NumIdentificacion, carrera, count(NumIdentificacion) as total
		from licenciados
		where NombreAsignatura in (select asignaturas.NombreAsignatura from asignaturas where asignaturas.Carrera = (select Uid from carreras where carreras.Carrera = licenciados.Carrera)) and Nota >= 5.0
		group by NumIdentificacion
	) as temp
where (select count(1) from asignaturas where carrera = (select Uid from carreras where carreras.Carrera = temp.carrera)) = temp.total
);
	set @exito = 1;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `BajaDarAsignaturaProfesor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDarAsignaturaProfesor`(UidAsig bigint(16), UidProf bigint(16), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	if (select count(*) from asignaturasprofesores where UidAsignatura = UidAsig and UidProfesor = UidProf) > 0 then
		delete from asignaturasprofesores where UidAsignatura = UidAsig and UidProfesor = UidProf;
		set @exito = 1;
		set @salida =  'Se ha dado de baja el registro';
	else
		set @exito = 0;
		set @salida = 'No existe el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `BajaDeAsignatura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeAsignatura`(id bigint, out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	if (select count(*) from asignaturas where uid= id) > 0 then
		update asignaturas set Activo = 0, FechaBaja = now() where uid = id;
		set @exito = 1;
		set @salida = 'Se ha dado de baja el registro';
	else
		set @exito = 0;
		set @salida = 'No existe el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `BajaDeCarrera`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeCarrera`(id bigint, out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	if (select count(*) from carreras where Uid= id) > 0 then
		delete from carreras where Uid = id;
		set @exito = 1;
		set @salida = 'Se ha dado de baja el registro';
	else
		set @exito = 0;
		set @salida = 'No existe el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `BajaDeFacultad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeFacultad`(id bigint, out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	if (select count(*) from facultades where Uid= id) > 0 then
		delete from facultades where Uid = id;
		set @exito = 1;
		set @salida = 'Se ha dado de baja el registro';
	else
		set @exito = 0;
		set @salida = 'No existe el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `BajaDeLocalidad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeLocalidad`(id bigint, out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	if (select count(*) from localidades where Uid= id) > 0 then
		delete from localidades where Uid = id;
		set @exito = 1;
		set @salida = 'Se ha dado de baja el registro';
	else
		set @exito = 0;
		set @salida = 'No existe el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `BajaDeMatriculaAsignatura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeMatriculaAsignatura`(UidMat bigint(16), UidAsig bigint(16), OUT exito  int(11), OUT salida int(11))
begin
	START TRANSACTION;
	if (select count(*) from matriculasasignaturas where UidMatricula = UidMat and UidAsignatura=UidAsig and Activo = 1)  > 0 then
		update matriculasasignaturas set
			Activo = 0
		where
			UidMatricula = UidMat and UidAsignatura = UidAsig and Activo = 1;
		set @exito = 1;
		set @salida = 'Se ha dado de baja el registro';
	else
		set @exito = 0;
		set @salida = ' No existe esta asignatura en esta matrícula';
	end if;
	set @exito = 1;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `BajaDePais`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDePais`(id int(11), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	if (select count(*) from paises where Uid= id) > 0 then
		delete from paises where Uid = id;
		set @exito = 1;
		set @salida = 'Se ha dado de baja el registro';
	else
		set @exito = 0;
		set @salida = 'No existe el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `BajaDeProvincia`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeProvincia`(id int(11), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	if (select count(*) from provincias where Uid= id) > 0 then
		delete from provincias where Uid = id;
		set @exito = 1;
		set @salida = 'Se ha dado de baja el registro';
	else
		set @exito = 0;
		set @salida = 'No existe el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `BajaDeRama`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeRama`(id bigint, out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	if (select count(*) from ramas where Uid= id) > 0 then
		delete from ramas where Uid = id;
		set @exito = 1;
		set @salida = 'Se ha dado de baja el registro';
	else
		set @exito = 0;
		set @salida = 'No existe el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `ConsultaAlumnosAsignatura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaAlumnosAsignatura`(UidAsig bigint(16) , OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	set @exito=1;

        set @salida =concat( 'select personas.Uid, personas.Nombre, personas.Apellidos, Anio from matriculas, matriculasasignaturas, personas ',
						' where matriculas.Uid = matriculasasignaturas.UidMatricula and matriculas.UidAlumno = personas.Uid ',

						' and (matriculas.Anio >= year(convert((select Valor from kumenya_biblioteca.configuracion where NombreAtributo=''FechaInicioCurso''), date))',
            ' or matriculas.Anio >= year(convert((select Valor from kumenya_biblioteca.configuracion where NombreAtributo=''FechaInicioCurso''), date)) - 1) and matriculas.Activo = 1 and matriculasasignaturas.Activo = 1 ',
						' and Convalidada = 0 and UidAsignatura = ', UidAsig,
            ' ORDER BY personas.Apellidos');
	select @exito, @salida;
	COMMIT;
END$$

DROP PROCEDURE IF EXISTS `ConsultaAlumnosCarrera`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaAlumnosCarrera`(UidCar bigint(16) , OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	set @exito=1;
        set @salida =concat( 'select distinct max(matriculasasignaturas.UidMatricula) as Uid, personas.Nombre, personas.Apellidos, personas.CodigoPersona, personas.NumIdentificacion, Mencion from matriculas, matriculasasignaturas, personas ',
						' where matriculas.Uid = matriculasasignaturas.UidMatricula and matriculas.UidAlumno = personas.Uid ',

            'and (matriculas.Anio >= year(convert((select Valor from kumenya_biblioteca.configuracion where NombreAtributo=''FechaInicioCurso''), date))',
            ' or matriculas.Anio >= year(convert((select Valor from kumenya_biblioteca.configuracion where NombreAtributo=''FechaInicioCurso''), date)) - 1) and matriculas.Activo = 1 and matriculasasignaturas.Activo = 1 ',
						' and UidAsignatura in (select Uid from asignaturas where Vigente = 1 and Activo = 1 and Carrera =  ', UidCar,
            ' and Convalidada = 0) group by personas.Uid order by personas.Apellidos');
	select @exito, @salida;
	COMMIT;

END$$

DROP PROCEDURE IF EXISTS `ConsultaAsignaturas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaAsignaturas`(carrier bigint(16) , OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	set @exito=1;
        set @salida =concat( 'select Uid, NombreAsignatura, Curso, Ponderacion from asignaturas where Activo = 1 and carrera = ', carrier, ' order by Curso, NombreAsignatura');
	select @exito, @salida;
	COMMIT;
END$$

DROP PROCEDURE IF EXISTS `ConsultaCarreras`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaCarreras`(OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
        set @salida = 'select * from carreras';
	set @exito=1;
	select @exito, @salida;
	COMMIT;
END$$

DROP PROCEDURE IF EXISTS `ConsultaDeAlumno`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeAlumno`(nombre varchar(50), apellidos varchar(50), codigoPersona varchar(10),  numIdentificacion varchar(20), out exito int(11), out seleccion varchar(500))
begin
set @exito = 1;
set @seleccion = concat_ws('where','select Uid, Nombre, Apellidos, CodigoPersona, NumIdentificacion, TipoPersona from personas ', concat_ws(' and ', concat(" Nombre like '%", nombre,"%' "), concat(" Apellidos like '%", apellidos,"%' "), concat(" CodigoPersona like '%", codigoPersona,"%' "), concat(" NumIdentificacion like '%", numIdentificacion,"%' "),' Activo=1 ',' TipoPersona=''Alumno'' order By Apellidos'));
select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeConvalidacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeConvalidacion`(nombre varchar(50), apellidos varchar(50), codigoPersona varchar(10),  numIdentificacion varchar(20), out exito int(11), out seleccion varchar(500))
begin
set @exito = 1;
set @seleccion = concat_ws('where','select matriculas.Uid, Nombre, Apellidos, CodigoPersona, NumIdentificacion, matriculas.Anio, matriculas.Observaciones from matriculas left join personas on UidAlumno = personas.Uid ', concat_ws(' and ', concat(" Nombre like '%", nombre,"%' "), concat(" Apellidos like '%", apellidos,"%' "), concat(" CodigoPersona like '%", codigoPersona,"%' "), concat(" NumIdentificacion like '%", numIdentificacion,"%' "),' Convalidada = 1 ',' matriculas.Activo=1 ',' personas.Activo=1 ',' TipoPersona=''Alumno'' order By Apellidos'));
select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeMatricula`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeMatricula`(UidAlum bigint(16), OUT exito  int(11), OUT seleccion varchar(500))
begin
	set @exito = 1;
	set @seleccion = concat('select anio, nombreasignatura, notafinal from asignaturas, matriculasasignaturas, matriculas where UidMatricula in (select max(Uid) from matriculas where UidAlumno=', UidAlum, ' and Activo = 1) order by anio;');
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDePAS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDePAS`(nombre varchar(50), apellidos varchar(50), codigoPersona varchar(10),  numIdentificacion varchar(20), out exito int(11), out seleccion varchar(500))
begin
set @exito = 1;
set @seleccion = concat_ws('where','select Uid, Nombre, Apellidos, CodigoPersona, NumIdentificacion, TipoPersona from personas ', concat_ws(' and ', concat(" Nombre like '%", nombre,"%' "), concat(" Apellidos like '%", apellidos,"%' "), concat(" CodigoPersona like '%", codigoPersona,"%' "), concat(" NumIdentificacion like '%", numIdentificacion,"%' "),' Activo=1 ',' TipoPersona=''PAS'' '));
select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeProfesor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeProfesor`(nombre varchar(50), apellidos varchar(50), codigoPersona varchar(10),  numIdentificacion varchar(20), out exito int(11), out seleccion varchar(500))
begin
set @exito = 1;
set @seleccion = concat_ws('where','select Uid, Nombre, Apellidos, CodigoPersona, NumIdentificacion, TipoPersona from personas ', concat_ws(' and ', concat(" Nombre like '%", nombre,"%' "), concat(" Apellidos like '%", apellidos,"%' "), concat(" CodigoPersona like '%", codigoPersona,"%' "), concat(" NumIdentificacion like '%", numIdentificacion,"%' "),' Activo=1 ',' TipoPersona=''Profesor'' '));
select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `ConsultaFacultades`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaFacultades`(OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
        set @salida = 'select * from facultades';
	set @exito=1;
	select @exito, @salida;
	COMMIT;
END$$

DROP PROCEDURE IF EXISTS `ConsultaLocalidades`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaLocalidades`(OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
        set @salida = 'select * from localidades';
	set @exito=1;
	select @exito, @salida;
	COMMIT;
END$$

DROP PROCEDURE IF EXISTS `ConsultaMatriculas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaMatriculas`(UidAlum bigint(16), UidAsig bigint(16), Anio int, out exito int(11), out seleccion varchar(500))
begin
	set @exito = 1;
	set @seleccion = concat_ws('where','select matriculas.Uid, Anio, personas.Apellidos, personas.Nombre, personas.NumIdentificacion, DocumentacionCompleta, BecaGobierno, matriculas.Observaciones from matriculas, personas ', concat_ws(' and ',
																concat(' UidAlumno= ''', UidAlum,''' '),
																concat(' Anio= ''', Anio,''' '),
																concat(' personas.Uid = matriculas.UidAlumno '),
																concat(' matriculas.Uid in (select UidMatricula from matriculasasignaturas where UidAsignatura=  ''', UidAsig,''' )'),' matriculas.Activo=1 order by Anio DESC, Apellidos'));
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `ConsultaMatriculasParametros`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaMatriculasParametros`(UidAlum bigint(16), UidAsig bigint(16), Anno int, out exito int(11), out seleccion varchar(500))
begin
	set @exito = 1;
	set @seleccion = concat_ws('where','select * from matriculas ', concat_ws(' and ', concat(' UidAlumno= ''', UidAlum,''' '), concat(' Anio= ''', Anno,''' '),
			concat(' Uid in (select UidMatricula from matriculasasignaturas where UidAsignatura=  ''', UidAsig,''' )'),' Activo=1 '));
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `ConsultaPaises`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaPaises`(OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
        set @salida = 'select * from paises';
	set @exito=1;
	select @exito, @salida;
	COMMIT;
END$$

DROP PROCEDURE IF EXISTS `ConsultaProvincias`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaProvincias`(OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
        set @salida = 'select * from provincias';
	set @exito=1;
	select @exito, @salida;
	COMMIT;
END$$

DROP PROCEDURE IF EXISTS `ConsultaRamas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaRamas`(OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
        set @salida = 'select * from ramas';
	set @exito=1;
	select @exito, @salida;
	COMMIT;
END$$

DROP PROCEDURE IF EXISTS `ConsultarAsignaturaProfesor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarAsignaturaProfesor`(UidAsig bigint(16), UidProf bigint(16), out exito int(11), out seleccion varchar(500))
begin
	set @exito = 1;
	set @seleccion = concat_ws('where','select asignaturasprofesores.UidProfesor as Uid, personas.Nombre, personas.Apellidos from asignaturasprofesores, asignaturas, personas ',
								concat_ws(' and ', concat(' asignaturasprofesores.UidAsignatura = ''', UidAsig,''' '), concat(' asignaturasprofesores.UidProfesor = ''', UidProf,''' '),
											      ' asignaturasprofesores.UidAsignatura = asignaturas.Uid and asignaturasprofesores.UidProfesor = personas.Uid '));
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `ConsultarListadoAsignaturasProfesor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarListadoAsignaturasProfesor`(UidProf bigint(16) , OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	set @exito=1;
        set @salida =concat( 'select asignaturas.Uid, asignaturas.NombreAsignatura, asignaturas.Curso, carreras.Carrera from asignaturas, carreras',
						' where Activo = 1 and  asignaturas.Carrera =  carreras.Uid and asignaturas.Uid in',
						' (select UidAsignatura from asignaturasprofesores, carreras where asignaturasprofesores.UidProfesor = ', UidProf,
            ') order by Carrera, Curso, NombreAsignatura');
	select @exito, @salida;
	COMMIT;
END$$

DROP PROCEDURE IF EXISTS `CONTROLCURSO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CONTROLCURSO`(UidAlum bigint(16))
begin
	
	set @numAsignaturas = (select count(UidAsignatura) from matriculasasignaturas where UidMatricula  in  (select max(Uid) from matriculas where UidAlumno=UidAlum));
	set @numAprobadas =  (select count(UidAsignatura) from matriculasasignaturas where UidMatricula  in  (select max(Uid) from matriculas where UidAlumno=UidAlum) and
		notafinal >= (select Valor from kumenya_biblioteca.configuracion where NombreAtributo='CorteAprobado'));
	set @aprobado = cast((@numAprobadas/@numAsignaturas) * 100 as unsigned) ;
	set @numNoPasables = (select count(UidAsignatura) from matriculasasignaturas where UidMatricula  in  (select max(Uid) from matriculas where UidAlumno=UidAlum) and
		notafinal < (select valor from kumenya_biblioteca.configuracion where NombreAtributo='CorteSuspenso'));
	if ((@aprobado > cast((select Valor from kumenya_biblioteca.configuracion where NombreAtributo='PorCiertoAprobado') as unsigned) ) and (@numNoPasables <= 2)) then
		set @salida = ' Pasas';
	else
		set @salida = 'Repites';
	end if;
	
	select  @salida;
end$$

DROP PROCEDURE IF EXISTS `Convalidar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Convalidar`(IdRegister bigint(16), IdSubject bigint(16), Mark float, out success int(11), out message varchar(20))
begin
	START TRANSACTION;
	update matriculasasignaturas set NotaFinal = Mark, FechaModificacion = now() where UidMatricula = IdRegister and UidAsignatura = IdSubject;
	set @success = 1;
	set @message = 'Se ha creado el registro';
	if @success = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @success, @message;

end$$

DROP PROCEDURE IF EXISTS `DarMatricula`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DarMatricula`(UidAlum bigint(16), out exito int(11), out salida varchar(200))
BEGIN
	
	START TRANSACTION;
	set @exito = 1;
	set @salida = (select MAX(Uid) from matriculas where UidAlumno = UidAlum);
	if @salida is null then
		set @exito = 0;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
END$$

DROP PROCEDURE IF EXISTS `DeleteMatricula`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteMatricula`(UidMat bigint(16), OUT exito  int(11), OUT seleccion varchar(500))
begin
	set @exito = 1;
	set @seleccion = concat('delete from matriculas where matriculas.Uid = ', UidMat);
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `DeleteMatriculasAsignaturas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteMatriculasAsignaturas`(UidMat bigint(16), OUT exito  int(11), OUT seleccion varchar(500))
begin
	set @exito = 1;
	set @seleccion = concat('delete from matriculasasignaturas where matriculasasignaturas.UidMatricula = ', UidMat);
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `DetalleAsignatura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleAsignatura`(UidAsig bigint(16), OUT exito  int(11), OUT salida varchar(800), OUT tabla varchar(50))
BEGIN
	START TRANSACTION;
	set @exito=1;
        set @salida =concat( 'select Uid, NombreAsignatura, Horas, Tipo, DuracionAsignatura, Periodo, Curso, Departamento, Carrera, Facultad, Ponderacion, Vigente from asignaturas where Activo = 1 and Uid =' , UidAsig);
	set @tabla = 'asignaturas';
	select @exito, @salida, @tabla;
	COMMIT;
END$$

DROP PROCEDURE IF EXISTS `DetalleDeAlumno`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleDeAlumno`(Id bigint(16), OUT exito int(11), OUT salida varchar(800), OUT tabla varchar(100))
begin
	set @exito=1;
	set @salida = concat('select personas.Uid, personas.Nombre, personas.Apellidos, personas.CodigoPersona, personas.TipoPersona, personas.NumIdentificacion, personas.Observaciones, personas.FechaNacimiento, personas.LugarNacimiento, personas.Direccion, personas.Distrito, personas.Localidad, personas.Provincia, personas.Pais, personas.Sexo, personas.EstadoCivil, alumnos.* from personas, alumnos where personas.Uid=alumnos.Uid and Activo = 1 and alumnos.Uid =' , Id);
	set @tabla = 'personas';
	select @exito, @salida, @tabla;
end$$

DROP PROCEDURE IF EXISTS `DetalleDePAS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleDePAS`(Id bigint(16), OUT exito int(11), OUT salida varchar(800), OUT tabla varchar(100))
begin
	set @exito=1;
	set @salida = concat('select personas.Uid, personas.Nombre, personas.Apellidos, personas.CodigoPersona, personas.TipoPersona, personas.NumIdentificacion, personas.Observaciones, personas.FechaNacimiento, personas.LugarNacimiento, personas.Direccion, personas.Distrito, personas.Localidad, personas.Provincia, personas.Pais, personas.Sexo, personas.EstadoCivil, pas.* from personas, pas where personas.Uid=pas.Uid and Activo = 1 and personas.Uid =' , Id);
	set @tabla = 'personas';
	select @exito, @salida, @tabla;
end$$

DROP PROCEDURE IF EXISTS `DetalleDeProfesor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleDeProfesor`(Id bigint(16), OUT exito int(11), OUT salida varchar(800), OUT tabla varchar(100))
begin
	set @exito=1;
	set @salida = concat('select personas.Uid, personas.Nombre, personas.Apellidos, personas.CodigoPersona, personas.TipoPersona, personas.NumIdentificacion, profesores.Visitante, personas.Observaciones, personas.FechaNacimiento, personas.LugarNacimiento, personas.Direccion, personas.Distrito, personas.Localidad, personas.Provincia, personas.Pais, personas.Sexo, personas.EstadoCivil, profesores.Especialidad from personas, profesores where personas.Uid=profesores.Uid and Activo = 1 and personas.Uid =' , Id);
	set @tabla = 'personas';
	select @exito, @salida, @tabla;
end$$

DROP PROCEDURE IF EXISTS `DetalleMatricula`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleMatricula`(UidMat bigint(16), OUT exito  int(11), OUT seleccion varchar(500))
begin
	set @exito = 1;
	set @seleccion = concat('select asignaturas.NombreAsignatura,  asignaturas.Horas, asignaturas.Ponderacion, asignaturas.Curso, SesionPrimera, NotaPrimera, SesionSegunda, NotaSegunda, SesionExtraordinaria, NotaExtraordinaria, NotaFinal from matriculasasignaturas, asignaturas where matriculasasignaturas.UidAsignatura = asignaturas.Uid and matriculasasignaturas.UidMatricula = ', UidMat);
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `DetalleMatriculaAsignatura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleMatriculaAsignatura`(UidAsig bigint(16), UidMat bigint(16), OUT exito int(11), OUT salida varchar(800))
BEGIN
	set @exito=1;
	set @salida = concat_ws(' where ','select SesionPrimera, NotaPrimera, SesionSegunda, NotaSegunda, SesionExtraordinaria, NotaExtraordinaria, NotaFinal from matriculasasignaturas ',
								concat_ws(' and ', concat('UidMatricula= ', UidMat),
											      concat('UidAsignatura= ', UidAsig)
										 )
						);
  select @exito, @salida;
END$$

DROP PROCEDURE IF EXISTS `DetalleMatriculaConvalidacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleMatriculaConvalidacion`(UidMat bigint(16), OUT exito  int(11), OUT seleccion varchar(500))
begin
	set @exito = 1;
	set @seleccion = concat('select matriculasasignaturas.UidAsignatura as Uid, asignaturas.NombreAsignatura,  asignaturas.Curso, NotaFinal from matriculasasignaturas, asignaturas where matriculasasignaturas.UidAsignatura = asignaturas.Uid and matriculasasignaturas.UidMatricula = ', UidMat, ' order by Curso, NombreAsignatura');
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `DetallesMencionMatricula`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetallesMencionMatricula`(Id bigint(16), out exito int(11), out salida varchar(500))
BEGIN
  START TRANSACTION;
  set @porcentaje = PorcentajeCurso (Id);
  update matriculas set Porcentaje = @porcentaje, FechaModificacion = now() where Uid = Id;
  set @exito=1;
  set @salida = concat('SELECT matriculas.Uid, personas.Uid as Uidalumnos, Nombre, Apellidos, CodigoPersona, NumIdentificacion, Mencion, Porcentaje ',
    'from matriculas, personas WHERE personas.Uid = matriculas.UidAlumno AND matriculas.Uid = ''',Id,"'");
  COMMIT;
  select @exito, @salida;
END$$

DROP PROCEDURE IF EXISTS `DetallesModificacionMatricula`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetallesModificacionMatricula`(Id bigint(16), out exito int(11), out salida varchar(500))
BEGIN
        set @exito=1;
	set @salida = concat('SELECT matriculas.Uid, personas.Uid as Uidalumnos, Nombre, Apellidos, CodigoPersona, NumIdentificacion, Anio, DocumentacionCompleta, BecaGobierno, matriculas.Observaciones ',
				'from matriculas, personas WHERE personas.Uid = matriculas.UidAlumno AND matriculas.Uid = ''',Id,"'");
        select @exito, @salida;
END$$

DROP PROCEDURE IF EXISTS `GenerarExpediente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerarExpediente`(UidAlum bigint(16), OUT exito  int(11), OUT seleccion varchar(500))
begin
	set @exito = 1;
	set @seleccion = concat('select Anio, NombreAsignatura, Curso, DuracionAsignatura, NotaFinal from asignaturas, matriculasasignaturas, matriculas ',
						' where asignaturas.Uid = matriculasasignaturas.UidAsignatura and matriculas.Uid = matriculasasignaturas.UidMatricula ',
						' and matriculasasignaturas.UidMatricula in (select Uid from matriculas where UidAlumno=', UidAlum, ' and Activo = 1) order by Anio;');
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `InformeEscolarAlumnos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InformeEscolarAlumnos`(carrier varchar(100), profe varchar(100), facul varchar(100), asigna varchar(100), OUT exito int(11), OUT seleccion varchar(400))
begin
	set @exito = 1;
	   set @seleccion = concat_ws('where', concat('select distinct concat(personas.Nombre," ", personas.Apellidos) as Alumno, personas.NumIdentificacion ' ,
										   '  from personas, alumnos, asignaturas, facultades, carreras, asignaturasprofesores, matriculas, matriculasasignaturas, profesores ',
										   concat_ws(' where ',  ', (select personas.Uid, personas.Nombre, personas.Apellidos from personas, asignaturasprofesores ',
													  concat_ws(' and ', concat(' concat(personas.Nombre, " ",personas.Apellidos) like "%',profe,'%" '),
													  			' personas.Uid = asignaturasprofesores.UidProfesor ) as tem '
														     	   )
												    )
										    ),
									concat_ws(' and ',   concat(' carreras.Carrera like "%', carrier, '%" '),
													concat(' facultades.Facultad like "%', facul, '%" '),
													concat(' asignaturas.NombreAsignatura like "%', asigna, '%" '),
													concat(' personas.Uid = alumnos.Uid '),
													concat(' asignaturas.Facultad = facultades.Uid '),
													concat(' asignaturas.Carrera = carreras.Uid '),
													concat(' alumnos.Uid = matriculas.UidAlumno '),
													concat(' matriculas.Uid = matriculasasignaturas.UidMatricula '),
													concat(' matriculasasignaturas.UidAsignatura = asignaturas.Uid '),
													concat(' asignaturas.Uid = asignaturasprofesores.UidAsignatura '),
													concat(' tem.Uid = asignaturasprofesores.UidProfesor'),
													concat(' matriculas.anio = (select year(Valor) from kumenya_biblioteca.configuracion where  NombreAtributo = ''FechaInicioCurso'' ) ')
											)
							);
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `InformeEscolarTotalAlumnos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InformeEscolarTotalAlumnos`(carrier varchar(100), profe varchar(100), facul varchar(100), asigna varchar(100), OUT exito int(11), OUT seleccion varchar(400))
begin
	set @exito = 1;
	   set @seleccion = concat_ws('where', concat('select count(distinct personas.NumIdentificacion) as Total   ' ,
										   '  from personas, alumnos, asignaturas, facultades, carreras, asignaturasprofesores, matriculas, matriculasasignaturas, profesores ',
										   concat_ws(' where ',  ', (select personas.Uid, personas.Nombre, personas.Apellidos from personas, asignaturasprofesores ',
													  concat_ws(' and ', concat(' concat(personas.Nombre, " ",personas.Apellidos) like "%',profe,'%" '),
													  			' personas.Uid = asignaturasprofesores.UidProfesor ) as tem '
														     	   )
												    )
										    ),
									concat_ws(' and ',   concat(' carreras.Carrera like "%', carrier, '%" '),
													concat(' facultades.Facultad like "%', facul, '%" '),
													concat(' asignaturas.NombreAsignatura like "%', asigna, '%" '),
													concat(' personas.Uid = alumnos.Uid '),
													concat(' asignaturas.Facultad = facultades.Uid '),
													concat(' asignaturas.Carrera = carreras.Uid '),
													concat(' alumnos.Uid = matriculas.UidAlumno '),
													concat(' matriculas.Uid = matriculasasignaturas.UidMatricula '),
													concat(' matriculasasignaturas.UidAsignatura = asignaturas.Uid '),
													concat(' asignaturas.Uid = asignaturasprofesores.UidAsignatura '),
													concat(' tem.Uid = asignaturasprofesores.UidProfesor'),
													concat(' matriculas.anio = (select year(Valor) from kumenya_biblioteca.configuracion where  NombreAtributo = ''FechaInicioCurso'' ) ')
											)
							);
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `InformePersonalAlumnos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InformePersonalAlumnos`(Loca varchar(100), Prov varchar(100), Pai varchar(100), Sex enum('Mujer','Hombre'), Anio int, Facultad varchar(100), Departamento varchar(100), Carrera varchar(100), OUT exito int(11), OUT seleccion varchar(400))
begin
	set @exito = 1;
	set @seleccion = concat_ws('where', 'select distinct matriculas.Anio, personas.Nombre, personas.Apellidos, personas.NumIdentificacion, localidades.Localidad, provincias.Provincia, paises.Pais, personas.Sexo, personas.FechaNacimiento, alumnos.EscuelaBachiller, alumnos.UniversidadAnterior, facultades.Facultad, asignaturas.Departamento, carreras.Carrera, asignaturas.Curso from carreras, asignaturas, matriculas, facultades, matriculasasignaturas, personas, alumnos, localidades, provincias, paises ',
								concat_ws(' and ', concat(' localidades.Localidad like "%', Loca, '%" '),
									concat(' provincias.Pfrovincia like "%', Prov, '%" '),
									concat(' paises.Pais like "%', Pai, '%" '),
									concat(' personas.Sexo = "', Sex, '" '),
									concat(' matriculas.Anio =  "', Anio, '" '),
									concat(' facultades.Facultad like "%', Facultad, '%" '),
									concat(' asignaturas.Departamento like "%', Departamento, '%" '),
									concat(' carreras.Carrera like "%', Carrera, '%" '),
									concat(' personas.Uid = alumnos.Uid'),
									concat(' personas.Localidad = localidades.Uid'),
									concat(' personas.Provincia = provincias.Uid'),
									concat(' personas.Pais = paises.Uid'),
									concat(' alumnos.Uid = matriculas.UidAlumno'),
									concat(' matriculas.Uid = matriculasasignaturas.UidMatricula'),
									concat(' matriculasasignaturas.UidAsignatura = asignaturas.Uid'),
									concat(' asignaturas.Facultad = facultades.Uid'),
									concat(' asignaturas.Carrera = carreras.Uid')
								)
			);
	
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `InformePersonalTotalAlumnos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InformePersonalTotalAlumnos`(Loca varchar(100), Prov varchar(100), Pai varchar(100), Sex enum('Mujer','Hombre'), Anio int, UniversidadAnt varchar(100), OUT exito int(11), OUT seleccion varchar(400))
begin
	set @exito = 1;
	set @seleccion = concat_ws('where', 'select count(1) from personas, alumnos, localidades, provincias, paises ',
								concat_ws(' and ', concat(' localidades.Localidad like "%', Loca, '%" '),
											      concat(' provincias.Provincia like "%', Prov, '%" '),
											      concat(' paises.Pais like "%', Pai, '%" '),
											      concat(' personas.Sexo = "', Sex, '" '),
											      concat(' year (personas.FechaNacimiento) =  "', Anio, '" '),
											      concat(' alumnos.UniversidadAnterior like "%', UniversidadAnt, '%" '),
											      concat(' personas.Uid = alumnos.Uid '),
											      concat(' personas.Localidad = localidades.Uid '),
											      concat(' personas.Provincia = provincias.Uid '),
											      concat(' personas.Pais = paises.Uid')
										)
							);
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `Licenciar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Licenciar`(UidAlum bigint(16), UidCarrier bigint(16), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	set @exito = 0;
	set @sancionBiblio = (select count(1) from kumenya_biblioteca.prestamos where UidPersona = UidAlum and HaySancion = 'Si');
	set @cuenta = (select count(1) from kumenya_contabilidad.cuentascontables where UidTercero = UidAlum  and TipoTercero = 'Persona'  and Debe <> Haber);
	set @asigCarrera = (select count(1) from asignaturas where carrera = UidCarrier and Activo = 1);
	set @asigAprobadas = (select count(1) from matriculasasignaturas, matriculas, asignaturas
							where matriculasasignaturas.UidMatricula = matriculas.Uid and matriculasasignaturas.UidAsignatura = asignaturas.Uid and
									matriculas.UidAlumno=UidAlum and asignaturas.Carrera = UidCarrier and matriculasasignaturas.NotaFinal >= 5.0 and Activo = 1);
	if (@sancionBiblio = 0 and @cuenta = 0 and @asigCarrera = @asigAprobadas and @asigCarrera > 0) then
				set @carrera = (select Carrera from carreras where Uid = UidCarrier);
				insert into licenciados
				select UidAlum, concat(personas.Nombre, ' ', personas.Apellidos) as persona, personas.NumIdentificacion,matriculas.Anio, NombreAsignatura, Curso, @carrera, NotaFinal
					from asignaturas, matriculasasignaturas, matriculas ,personas
				where asignaturas.Uid = matriculasasignaturas.UidAsignatura and matriculas.Uid = matriculasasignaturas.UidMatricula and matriculas.UidAlumno = personas.Uid
					and personas.Uid = UidAlum and asignaturas.Carrera = UidCarrier
					and matriculasasignaturas.UidMatricula in (select Uid from matriculas  where Activo = 1 and UidAlumno=UidAlum);
				delete from matriculasasignaturas where UidMatricula in (select Uid from matriculas where UidAlumno = UidAlum);
				delete from matriculas where UidAlumno = UidAlum;
				set @exito = 1;
				set @salida = 'El alumno puede recibir el título de la carrera que ha cursado';
	else
		if @sancionBiblio > 0 then
			set @salida = 'El alumno tiene sanciones pendientes de la biblioteca';
		else
			if @cuenta > 0 then
				set @salida = 'El alumno tiene pagos pendientes de la universidad';
			else
				if @asigCarrera = 0 then
					set @salida = 'La carrera no tiene asignaturas asociadas';
				else
					set @salida = 'El alumno no tiene aprobadas todas las asignaturas de la carrera';
				end if;
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `ListadoConvocatoriasAsignatura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ListadoConvocatoriasAsignatura`(UidAsig bigint(16), UidMat bigint(16), OUT exito int(11), OUT salida varchar(800), OUT tabla varchar(100))
BEGIN
	set @alumno = (select UidAlumno from matriculas where Uid = UidMat); 
	set @exito=1;
	set @salida = concat_ws(' where ','select SesionPrimera, NotaPrimera, SesionSegunda, NotaSegunda, SesionExtraordinaria, NotaExtraordinaria, NotaFinal from matriculasasignaturas ',
								concat_ws(' and ', concat('UidMatricula in (select Uid from matriculas where Activo = 1 and UidAlumno = ', @alumno, ')'),
											      concat('UidAsignatura= ', UidAsig)
										 )
						);
	set @tabla = 'matriculasasignaturas';
	select @exito, @salida, @tabla;
END$$

DROP PROCEDURE IF EXISTS `ModificacionDarAsignaturaProfesor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDarAsignaturaProfesor`(UidAsigOld bigint(16), UidProfOld bigint(16), UidAsigNew bigint(16), UidProfNew bigint(16), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	delete from asignaturasprofesores where UidAsignatura = UidAsigOld and UidProfesor = UidProfOld;
	if (select count(*) from asignaturasprofesores where UidAsignatura = UidAsigNew and UidProfesor = UidProfNew) = 0 then
			insert into asignaturasprofesores value (UidAsigNew, UidProfNew);
			set @exito = 1;
			set @salida =  'Se ha creado el registro';
	else
		set @exito = 0;
		set @salida =  'No se ha creado el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDeAlumno`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeAlumno`(Id bigint, Nombr varchar(50), Apellid varchar(50), CodPer varchar(10), TipoPer enum ('Alumno','PAS','Profesor'),NumId varchar(20), Observ varchar(600), FechaNac varchar(10), LugarNac varchar(100), Dir varchar(200), Distr varchar(100), Loca int, Prov int, Pai int, Sex enum('Mujer','Hombre'), EstadoCiv enum('Soltero','Casado','Viudo','Separado','Divorciado'), NombreCony varchar(50), NombrePa varchar(50), ProfesionPa varchar(50), NombreMa varchar(50), ProfesionMa varchar(50), CertificadoHomo enum('Si','No'), EscuelaBach varchar(100), RamaBach int, ResultadoBach varchar(100), AnioBach varchar(10), DiplomaBach enum('Si','No'), EstudiosUni enum('Si','No'), UniversidadAnt varchar(100), OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	if isnull(concat(Id,Nombr,Apellid,CodPer,TipoPer,NumId))=1 then
		set @exito = 0;
		set @salida = ValidarNullModificacionPersona(Id,Nombr,Apellid,CodPer,TipoPer,NumId);
	else
		if  (select NumIdentificacion from personas where Uid = Id) <> NumId then
			set @salida = 'No puede modificar el número de identificación';
			set @exito = 0;
		else
			if TipoPer <> 'Alumno' then
				set @salida = 'El tipo de persona debe ser Alumno';
				set @exito = 0;
			else
				if (select CodigoPersona from personas where Uid = Id) <> CodPer then
					set @salida = 'No puede modificar el código de la persona';
					set @exito = 0;
				else
					if (select count(*) from personas where CodigoPersona = CodPer) > 1 then
						set @salida = 'Código de persona ya existente';
						set @exito = 0;
					else
						call ModificacionDePersona (Id,Nombr,Apellid, CodPer, TipoPer, NumId,Observ,FechaNac,LugarNac,Dir,Distr,Loca,Prov,Pai,Sex,EstadoCiv);
						update alumnos
							set NombreConyuge = NombreCony,
							NombrePadre = NombrePa,
							ProfesionPadre = ProfesionPa,
							NombreMadre = NombreMa,
							ProfesionMadre = ProfesionPa,
							CertificadoHomologado = CertificadoHomo,
							EscuelaBachiller = EscuelaBach,
							RamaBachiller = RamaBach,
							ResultadoBachiller = ResultadoBach,
							AnioBachiller = AnioBach,
							DiplomaBachiller = DiplomaBach,
							EstudiosUniversitarios = EstudiosUni,
							UniversidadAnterior = UniversidadAnt
						where Uid = Id;
						set @exito = 1;
						set @salida = 'Se ha modificado el registro';
					end if;
				end if;
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `ModificacionDeAsignatura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeAsignatura`(id int(16), asig varchar(150), hor int, tip enum('Troncal','Obligatoria','Optativa','Libre Eleccion'), dur enum('Cuatrimestral','Semestral','Anual'), per enum('primero','segundo','ninguno'), cur int(5), depart varchar(150), car int(5), fac int (5), pond int(5), vig enum('Si','No'), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	set @exito = 0;
	if (select count(*) from asignaturas where uid= id) > 0 then
		if isnull(concat(asig,cur, depart, car, vig, pond)) then
			set @salida = ValidarNullAltaAsignatura(asig,cur, depart, car, vig, pond);
		else
			if !(dur = 'Anual' xor per = 'ninguno') and (cur <= (select kumenya_biblioteca.configuracion.Valor from kumenya_biblioteca.configuracion where kumenya_biblioteca.configuracion.NombreAtributo='MaximoAniosCarrera')) then
				update asignaturas set
					NombreAsignatura = asig,
					Horas = hor,
					Tipo = tip,
					DuracionAsignatura = dur,
					Periodo = per,
					Curso = 	cur,
					Departamento = depart,
					Carrera = car,
					Ponderacion = pond,
          Facultad = fac,
					Vigente = vig,
					FechaModificacion = now()
				where uid = id;
				set @exito = 1;
				set @salida = 'Se ha modificado el registro';
			else
				if (cur > (select kumenya_biblioteca.configuracion.Valor from kumenya_biblioteca.configuracion where kumenya_biblioteca.configuracion.NombreAtributo='MaximoAniosCarrera')) then
					set @salida= 'No es un curso válido';
				else
					set @salida = 'La duración de la asignatura es incoherente con el periodo de la misma';
				end if;
			end if;
		end if;
	else
		set @salida = 'No existe la asignatura';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDeCarrera`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeCarrera`(id int(11), value varchar(150), aniosCar int, aniosCiclo int, out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	update carreras set Carrera = value,
					AniosCarrera = aniosCar,
					AniosPrimerCiclo = aniosCiclo  where Uid=id;
	set @exito = 1;
	if @exito = 1 then
		COMMIT;
		set @salida =  'Se ha modificado el registro';
	else
		ROLLBACK;
		set @salida =  'No se ha modificado el registro';
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDeFacultad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeFacultad`(id int(11), value varchar(150), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	update facultades set Facultad = value where Uid=id;
	set @exito = 1;
	if @exito = 1 then
		COMMIT;
		set @salida =  'Se ha modificado el registro';
	else
		ROLLBACK;
		set @salida =  'No se ha modificado el registro';
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDeIdentificacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeIdentificacion`(Id bigint(16), NumIdNuevo varchar(20), out exito int(11), out salida varchar(50))
begin
	START TRANSACTION;
	if (select count(*) from personas where Uid = Id) > 0 then
		update personas
			set NumIdentificacion = NumIdNuevo
		where personas.Uid = Id;
		set @exito = 1;
		set salida = 'Se ha modificado el registro';
	else
		set @exito = 0;
		set  @salida = 'No existe la persona';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDeLocalidad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeLocalidad`(id int(11), value varchar(150), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	update localidades set Localidad = value where Uid=id;
	set @exito = 1;
	if @exito = 1 then
		COMMIT;
		set @salida =  'Se ha modificado el registro';
	else
		ROLLBACK;
		set @salida =  'No se ha modificado el registro';
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDeMatricula`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeMatricula`(UidMat bigint(16), UidAlum bigint(16), Year int, Doc bit, Beca varchar(6), Obs varchar(400), OUT exito  int(11), OUT salida int(11))
begin
	START TRANSACTION;
	if (select count(*) from matriculas where Uid=UidMat and UidAlumno = UidAlum and Anio=Year and Activo = 1)  > 0 then
		update matriculas set
			DocumentacionCompleta = Doc,
			BecaGobierno = Beca,
			Observaciones = Obs,
			FechaModificacion = now()
		where
			Uid=UidMat and UidAlumno = UidAlum and Anio=Year and Activo = 1;
		set @salida =  'Se ha modificado el registro';
		set @exito = 1;
	else
		set @salida = ' No existe esta matricula';
		set @exito = 0;
	end if;
	set @exito = 1;
	if @exito = 1 then
		COMMIT;
		
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDeMatriculaAsignatura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeMatriculaAsignatura`(UidMat bigint(16), UidAsig bigint(16), sesion1 varchar(50), sesion2 varchar(50), sesionExtra varchar(50), OUT exito  int(11), OUT salida int(11))
begin
	START TRANSACTION;
	if (select count(*) from matriculasasignaturas where UidMatricula = UidMat and UidAsignatura=UidAsig and Activo = 1)  > 0 then
		update matriculasasignaturas set
			SesionPrimera = sesion1,
			SesionSegunda = sesion2,
			SesionExtraordinaria = sesionExtra,
			FechaModificacion = now()
		where
			UidMatricula = UidMat and UidAsignatura = UidAsig and Activo = 1;
		set @exito = 1;
	else
		set @salida = ' No existe esta asignatura en esta matrícula';
		set @exito = 0;
	end if;
	set @exito = 1;
	if @exito = 1 then
		COMMIT;
		set @salida =  'Se ha modificado el registro';
	else
		ROLLBACK;
		set @salida =  'No se ha modificado el registro';
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDePais`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDePais`(id int(11), value varchar(150), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	update paises set Pais = value where Uid=id;
	set @exito = 1;
	if @exito = 1 then
		COMMIT;
		set @salida =  'Se ha modificado el registro';
	else
		ROLLBACK;
		set @salida =  'No se ha modificado el registro';
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDePAS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDePAS`(Id bigint,Nombr varchar(50), Apellid varchar(50), CodPer varchar(10), TipoPer enum ('Alumno','PAS','Profesor'),NumId varchar(20), Observ varchar(600), FechaNac varchar(10),  LugarNac varchar(100), Dir varchar(200),Distr varchar(100), Loca int, Prov int, Pai int, Sex enum('Mujer','Hombre'), EstadoCiv enum('Soltero','Casado','Viudo','Separado','Divorciado'), Estud varchar(50), Exper int(5), OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	if isnull(concat(Nombr,Apellid,CodPer,TipoPer,NumId))=1 then
		set @exito = 0;
		set @salida = ValidarNullModificacionPersona(Id,Nombr,Apellid,CodPer,TipoPer,NumId);
	else
		if  (select NumIdentificacion from personas where  Uid = Id) <> NumId then
			set @salida = 'No puede modificar el número de identificación';
			set @exito = 0;
		else
			if TipoPer <> 'PAS' then
				set @salida = 'El tipo de persona debe ser PAS';
				set @exito = 0;
			else
				if (select CodigoPersona from personas where Uid = Id) <> CodPer then
					set @salida = 'No puede modificar el código de la persona';
					set @exito = 0;
				else
					if isnull(Exper) then
						set @exito = 0;
						set @salida = 'Campo Experiencia no puede ser vacío';
					else
						call ModificacionDePersona(Id,Nombr,Apellid,CodPer,TipoPer,NumId,Observ,FechaNac,LugarNac,Dir,Distr,Loca,Prov,Pai,Sex,EstadoCiv);
						update pas
							set Estudios = Estud,
							Experiencia = Exper
						where Uid = Id;
						set @salida = 'Se ha modificado el registro';
						set @exito = 1;
					end if;
				end if;
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `ModificacionDePersona`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDePersona`(Id bigint(16), Nombr varchar(50), Apellid varchar(50), CodPer varchar(10), TipoPer enum ('Alumno','PAS','Profesor'),NumId varchar(20), Observ varchar(600), FechaNac varchar(10), LugarNac varchar(100), Dir varchar(200), Distr varchar(100), Loca int, Prov int, Pai int, Sex enum('Mujer','Hombre'), EstadoCiv enum('Soltero','Casado','Viudo','Separado','Divorciado'))
BEGIN

	update personas set
		Nombre = Nombr,
		Apellidos = Apellid,
		CodigoPersona = CodPer,
		TipoPersona = TipoPer,
		NumIdentificacion = NumId,
		Observaciones = Observ,
		FechaNacimiento = FechaNac,
		LugarNacimiento = LugarNac,
		Direccion = Dir,
		Distrito = Distr,
		Localidad = Loca,
		Provincia = Prov,
		Pais = Pai,
		Sexo = Sex,
		EstadoCivil = EstadoCiv,
		FechaModificacion = now()
	where Uid = Id;

END$$

DROP PROCEDURE IF EXISTS `ModificacionDeProfesor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeProfesor`(Id bigint,Nombr varchar(50), Apellid varchar(50), CodPer varchar(10), TipoPer enum ('Alumno','PAS','Profesor'),NumId varchar(20), Observ varchar(600), FechaNac varchar(10),  LugarNac varchar(100), Dir varchar(200), Distr varchar(100),Loca int, Prov int, Pai int, Sex enum('Mujer','Hombre'), EstadoCiv enum('Soltero','Casado','Viudo','Separado','Divorciado'), Esper varchar(50), Visita enum('No','Si'), OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	if isnull(concat(Nombr,Apellid,CodPer,TipoPer,NumId))=1 then
		set @exito = 0;
		set @salida = ValidarNullAltaPersona(Id,Nombr,Apellid,CodPer,TipoPer,NumId);
	else
		if  (select NumIdentificacion from personas where  Uid = Id) <> NumId then
			set @salida = 'No puede modificar el número de identificación';
			set @exito = 0;
		else
			if TipoPer <> 'Profesor' then
				set @salida = 'El tipo de persona debe ser Profesor';
				set @exito = 0;
			else
				if (select CodigoPersona from personas where Uid = Id) <> CodPer then
					set @salida = 'No puede modificar el código de la persona';
					set @exito = 0;
				else
					if isnull(Visita) then
						set @exito = 0;
						set @salida = 'El campo Visitante es obligatorio';
					else
						call ModificacionDePersona(Id,Nombr,Apellid,CodPer,TipoPer,NumId,Observ,FechaNac,LugarNac,Dir,Distr,Loca,Prov,Pai,Sex,EstadoCiv);
						update profesores
							set Especialidad = Esper,
							Visitante = Visita
						where Uid = Id;
						set @salida = 'Se ha modificado el registro';
						set @exito = 1;
					end if;
				end if;
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `ModificacionDeProvincia`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeProvincia`(id int(11), value varchar(150), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	update provincias set Provincia = value where Uid=id;
	set @exito = 1;
	if @exito = 1 then
		COMMIT;
		set @salida =  'Se ha modificado el registro';
	else
		ROLLBACK;
		set @salida =  'No se ha modificado el registro';
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDeRama`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeRama`(id int(11), value varchar(150), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	update ramas set Rama = value where Uid=id;
	set @exito = 1;
	if @exito = 1 then
		COMMIT;
		set @salida =  'Se ha modificado el registro';
	else
		ROLLBACK;
		set @salida =  'No se ha modificado el registro';
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDeUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeUsuario`(Id bigint, usuar varchar(45), pass varchar(45), person bigint, tipousuar enum ('Contable','Administrativo','TEDECO','Profesor','TEDECO','Bibliotecario'), out exito int(11), out salida varchar(100))
BEGIN
	START TRANSACTION;
	if (usuar is null) or (pass is null) or (person is null) or (tipousuar is null) or (Id is null) then
		set @exito = 0;
		set @salida = ValidarNullModificacionUsuario (Id,usuar, pass, person, tipousuar);
	else
		set @per = (select Uid from kumenya_matriculacion.personas where Uid = person and Activo = 1);
		if (@per is null) then
			set @salida = 'No existe la persona seleccionada';
			set @exito = 0;
		else
			if (select count(*) from usuarios where TipoUsuario = tipousuar and Uid != Id and Usuario = usuar and Activo = 1) > 0 then
				set @exito = 0;
				set @salida = 'Ya existe el usuario y rol seleccionados';
			else
				update usuarios
					set Uid = Id,
					Usuario = usuar,
					Contrasena = pass,
					Persona = person,
					TipoUsuario = tipousuar,
					FechaModificacion = now()
				where Uid = Id;
				set @exito = 1;
				set @salida = 'Se ha modificado el registro';
			end if;
		end if;
	end if;
	if (@exito = 0) then
		ROLLBACK;
	else
		COMMIT;
	end if;
	select @exito, @salida;
END$$

DROP PROCEDURE IF EXISTS `ModificacionMencionMatricula`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionMencionMatricula`(UidMat bigint(16), UidAlum bigint(16), Menc varchar(90), OUT exito  int(11), OUT salida varchar(100))
BEGIN
  START TRANSACTION;
	if (select count(*) from matriculas where Uid=UidMat and UidAlumno = UidAlum and Activo = 1)  > 0 then
		update matriculas set
			Mencion = Menc,
			FechaModificacion = now()
		where
			Uid=UidMat and UidAlumno = UidAlum and Activo = 1;
		set @salida =  'Se ha modificado el registro';
		set @exito = 1;
	else
		set @salida = ' No existe esta matrícula';
		set @exito = 0;
	end if;

  if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;

	select @exito, @salida;
END$$

DROP PROCEDURE IF EXISTS `ModificacionPrecioCarrera`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionPrecioCarrera`(id int(11), precioNacional float(11,2), monedaNacional varchar(10), precioExtranjero float(11,2), monedaExtranjera varchar(10), out exito int(11), out salida varchar(200))
BEGIN
	START TRANSACTION;
	update carreras set PrecioNacional = precioNacional,
          MonedaNacional = monedaNacional,
          PrecioExtranjero = precioExtranjero,
          MonedaExtranjera = monedaExtranjera where Uid=id;
	set @exito = 1;
	if @exito = 1 then
		COMMIT;
		set @salida =  'Se ha modificado el registro';
	else
		ROLLBACK;
		set @salida =  'No se ha modificado el registro';
	end if;
	select @exito, @salida;

END$$

DROP PROCEDURE IF EXISTS `MostrarAlumnosConvalidables`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarAlumnosConvalidables`()
begin

	select column_name, table_name, table_schema from information_schema.`COLUMNS`
        where ((table_name = 'matriculas') and column_name in ('Anio', 'Observaciones', 'Uid'))
	or ((table_name = 'carreras') and column_name in ('Carrera', 'Uid'))
        or ((table_name='asignaturas') and column_name in ('Curso'))
	or ((table_name='personas')  and column_name in ('Nombre', 'Apellidos', 'CodigoPersona', 'NumIdentificacion'))
 order by table_name desc;

end$$

DROP PROCEDURE IF EXISTS `MostrarAsignaturasAConvalidar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarAsignaturasAConvalidar`(IdStudies bigint(16), IdStud bigint(16), AcademYear int(5), out success int(11), out selection varchar(600))
begin

	
	if (select count(*) from matriculas where UidAlumno = IdStud) > 0 then
		
		
		set @selection = concat('select Uid, NombreAsignatura, Curso from asignaturas where Vigente = 1 and Uid in (select Uid from asignaturas where Vigente = 1 and ',
          							concat_ws(' and ' ,'Activo=1',concat(' Carrera = ', IdStudies),concat('Curso < ',AcademYear)),
					              		') union select Uid, NombreAsignatura, Curso from matriculasasignaturas right join asignaturas on UidAsignatura = Uid where Vigente = 1 and asignaturas.Activo = 1 and',
                					        ' ((Curso < ', AcademYear,
					                        ' and NotaFinal < (select Valor from kumenya_biblioteca.configuracion where NombreAtributo="CorteSuspenso")',
					                        ' or NotaFinal is null) or (Curso < ', AcademYear,
					                        ' and NotaFinal < (select Valor from kumenya_biblioteca.configuracion where NombreAtributo="Aprobado")',
					                        ' or NotaFinal is null)) and Carrera = ', IdStudies,
					                        ' and UidMatricula in (select Uid from matriculas WHERE UidAlumno = ', IdStud, ') order by Curso, NombreAsignatura');
	else
		
		set @selection	= concat('select Uid, NombreAsignatura, Curso from asignaturas where Curso < ', AcademYear, ' and Carrera = ', IdStudies, ' and Vigente = 1 and Activo = 1');
	end if;
	set @success = 1;
	select @success, @selection;

end$$

DROP PROCEDURE IF EXISTS `MostrarAsignaturasMatriculableAlumno`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarAsignaturasMatriculableAlumno`(UidAl bigint(16), UidCar bigint(16), OUT exito  int(11), OUT seleccion varchar(500))
begin
	START TRANSACTION;

   
	set @maxcurso = (select max(Curso) from asignaturas where Carrera = UidCar and Uid in (select UidAsignatura from matriculasasignaturas where UidMatricula in (select Uid from matriculas where UidAlumno=UidAl)));
    

	if (select count(1) from matriculas where UidAlumno = UidAl) > 0 and @maxcurso is not null then

		set @repites = ControlDeCurso(UidAl, UidCar);

		if @repites = 'Repites' then
      
      set @seleccion = concat('select Uid, NombreAsignatura, Curso from asignaturas where Activo = 1 and Vigente = 1 and Carrera = ', UidCar,
                              ' and Curso = ',@maxcurso,
                              ' and Uid not in (select UidAsignatura from matriculasasignaturas where NotaFinal >= ',(select valor from kumenya_biblioteca.configuracion where NombreAtributo='CorteRepetidores'),
                              ' and UidMatricula in (select Uid from matriculas where UidAlumno = ', UidAl,')) order by Curso, NombreAsignatura');

    else
      

  		set @seleccion = concat('select Uid, NombreAsignatura, Curso from asignaturas where Vigente = 1 and Uid in (select Uid from asignaturas where Vigente = 1 and ',
          							concat_ws(' and ' ,'Activo=1',concat(' Carrera = ', UidCar),concat('Curso =',@maxcurso + 1)),
					              		') union ', 'select Uid, NombreAsignatura, Curso from matriculasasignaturas right join asignaturas on UidAsignatura = Uid where Vigente = 1 and asignaturas.Activo = 1 and',
                            ' ((Curso = ', @maxcurso,
                            ' and NotaFinal < ', (select valor from kumenya_biblioteca.configuracion where NombreAtributo='CorteSuspenso'),
                            ' or NotaFinal is null) or (Curso < ', @maxcurso,
                            ' and NotaFinal < ', (select valor from kumenya_biblioteca.configuracion where NombreAtributo='Aprobado'),
                            ' or NotaFinal is null)) and Carrera = ', UidCar,
                            ' and UidMatricula = (select Max(Uid) from matriculas WHERE UidAlumno = ', UidAl, ') order by Curso, NombreAsignatura');


		end if;
	else
    
		set @seleccion = (select concat_ws(' and ','select Uid,NombreAsignatura, Curso from asignaturas where Activo=1 and Vigente = 1 and Curso = 1', concat('Carrera =', UidCar, ' order by Curso, NombreAsignatura')));
	end if;

  set @exito = 1;
	select @exito, @seleccion;



end$$

DROP PROCEDURE IF EXISTS `MostrarCamposActivarAlumno`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarCamposActivarAlumno`()
BEGIN
	select column_name, table_name, table_schema from information_schema.`COLUMNS` where ((table_name='matriculaspendientes')  and column_name in ('Identificacion'));
END$$

DROP PROCEDURE IF EXISTS `MostrarCamposProfesoresAsignaturas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarCamposProfesoresAsignaturas`()
BEGIN
	select column_name, table_name, table_schema from information_schema.`COLUMNS`
        where ((table_name='profesores')  and column_name in ('Uid'))
        OR ((table_name='personas')  and column_name in ('Nombre', 'Apellidos'))
        OR (table_name='asignaturas');
END$$

DROP PROCEDURE IF EXISTS `ObtenerUidProfesor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerUidProfesor`(UidUsu bigint(16), out exito int(11), out salida varchar(100))
begin
	set @exito = 1;
	set @salida = (select Persona from kumenya_biblioteca.usuarios where Uid = UidUsu);
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `PDFCursoCompleto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PDFCursoCompleto`(UidAlum bigint(16), UidCarrier bigint(16), out exito int(11), out seleccion varchar(400))
begin
	START TRANSACTION;
	set @exito = 0;
	set @PrimerCiclo = (select AniosCarrera from carreras where Uid = UidCarrier);
	set @sancionBiblio = (select count(1) from kumenya_biblioteca.prestamos where UidPersona = UidAlum and HaySancion = 'Si');
	set @cuenta = (select count(1) from kumenya_contabilidad.cuentascontables where UidTercero = UidAlum  and TipoTercero = 'Persona'  and Debe <> Haber);
	set @asigCarrera = (select count(1) from asignaturas where carrera = UidCarrier and curso <= @PrimerCiclo);
	set @asigAprobadas = (select count(1) from matriculasasignaturas, matriculas, asignaturas
							where matriculasasignaturas.UidMatricula = matriculas.Uid and matriculasasignaturas.UidAsignatura = asignaturas.Uid and
									matriculas.UidAlumno=UidAlum and asignaturas.Carrera = UidCarrier and matriculasasignaturas.NotaFinal >= 5.0 and asignaturas.Curso <= @PrimerCiclo);
	if (@sancionBiblio = 0 and @cuenta = 0 and @asigCarrera = @asigAprobadas and @asigCarrera > 0) then
		
		set @mat= (select max(matriculas.Uid)
					from matriculas, matriculasasignaturas, asignaturas
					where matriculas.Uid = matriculasasignaturas.UidMatricula and
					matriculasasignaturas.UidAsignatura = asignaturas.Uid and
					asignaturas.Curso <= @PrimerCiclo and matriculas.UidAlumno =UidAlum);
		
		set @anio = (select distinct(Anio) from matriculas where Uid=@mat);
		
		set @facultad = (select max(facultades.Facultad) from facultades, asignaturas where asignaturas.Carrera=1 and asignaturas.Facultad= facultades.Uid);
		
		set @num = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'NumeroPDF');
		set @num = @num + 1;
		update kumenya_biblioteca.configuracion set Valor = @num where NombreAtributo = 'NumeroPDF';
		
		set @notafeb = (select max(NotaPrimera) from matriculasasignaturas where UidMatricula = @mat);
		set @notajun = (select max(NotaSegunda) from matriculasasignaturas where UidMatricula = @mat);
		set @notaext = (select max(NotaExtraordinaria) from matriculasasignaturas where UidMatricula = @mat);
		if (@notaext >= 5) then
			set @convocatoria = (select distinct(SesionExtraordinaria) from matriculasasignaturas where UidMatricula = @mat);
			set @sesion = (select NombreAtributo from kumenya_biblioteca.configuracion where NombreAtributo ='SesionExtraordinaria');
		else
			if (@notajun >= 5) then
				set @convocatoria = (select distinct(SesionSegunda) from matriculasasignaturas where UidMatricula = @mat);
				set @sesion = (select NombreAtributo from kumenya_biblioteca.configuracion where NombreAtributo ='SesionSegunda');
			else
				set @convocatoria = (select distinct(SesionPrimera) from matriculasasignaturas where UidMatricula = @mat);
				set @sesion = (select NombreAtributo from kumenya_biblioteca.configuracion where NombreAtributo ='SesionPrimera');
			end if;
		end if;
		set @convocatoria =concat(@convocatoria, ' ');
		set @seleccion= concat( 'select concat_ws('' '', upper(Apellidos), concat(upper(substring(Nombre,1,1)) , lower(substring(Nombre, 2)))) as nombre, ',
							'localidades.Localidad as localidad, ',
							'year(FechaNacimiento) as anionacimiento, ''',
							@sesion,''' as sesion,',
							'concat(''',@convocatoria,''', ''',@anio, ''' ) as convocatoria,',
							' carreras.Carrera as carrera , ',
							'concat(''',@anio,''', ''-'', ''',@anio+1,''') as anioacademico, ',
							' now() as fecha, ',
							'(select valor from kumenya_biblioteca.configuracion where NombreAtributo = ''JefeEstudios'') as JefeEstudios, ',
							'(select valor from kumenya_biblioteca.configuracion where NombreAtributo = ''Rector'') as Rector ',
							' , ''',@facultad,''' as facultad',
							' , ''',@num, ''' as numero',
							' from personas, localidades, carreras '
							' where personas.Localidad = localidades.Uid and carreras.Uid = ', UidCarrier,' and personas.Uid= ', UidAlum, '; ');
		set @exito = 1;
		
	else
		if @sancionBiblio > 0 then
			set @seleccion = 'El alumno tiene sanciones pendientes de la biblioteca';
		else
			if @cuenta > 0 then
				set @seleccion = 'El alumno tiene pagos pendientes a la universidad';
			else
				if @asigCarrera = 0 then
					set @seleccion = 'La carrera no tiene asignaturas asociadas';
				else
					set @seleccion = 'El alumno no tiene aprobadas todas las asignaturas de la carrera';
				end if;
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `PDFPrimerCurso`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PDFPrimerCurso`(UidAlum bigint(16), UidCarrier bigint(16), out exito int(11), out seleccion varchar(400))
begin
	START TRANSACTION;
	set @exito = 0;
	set @PrimerCiclo = (select AniosPrimerCiclo from carreras where Uid = UidCarrier);
	set @sancionBiblio = (select count(1) from kumenya_biblioteca.prestamos where UidPersona = UidAlum and HaySancion = 'Si');
	set @cuenta = (select count(1) from kumenya_contabilidad.cuentascontables where UidTercero = UidAlum  and TipoTercero = 'Persona'  and Debe <> Haber);
	set @asigCarrera = (select count(1) from asignaturas where carrera = UidCarrier and curso <= @PrimerCiclo);
	set @asigAprobadas = (select count(1) from matriculasasignaturas, matriculas, asignaturas
							where matriculasasignaturas.UidMatricula = matriculas.Uid and matriculasasignaturas.UidAsignatura = asignaturas.Uid and
									matriculas.UidAlumno=UidAlum and asignaturas.Carrera = UidCarrier and matriculasasignaturas.NotaFinal >= 5.0 and asignaturas.Curso <= @PrimerCiclo);
	if (@sancionBiblio = 0 and @cuenta = 0 and @asigCarrera = @asigAprobadas and @asigCarrera > 0) then
		
		set @mat= (select max(matriculas.Uid)
					from matriculas, matriculasasignaturas, asignaturas
					where matriculas.Uid = matriculasasignaturas.UidMatricula and
					matriculasasignaturas.UidAsignatura = asignaturas.Uid and
					asignaturas.Curso <= @PrimerCiclo and matriculas.UidAlumno =UidAlum);
		
		set @anio = (select distinct(Anio) from matriculas where Uid=@mat);
		
		set @facultad = (select max(facultades.Facultad) from facultades, asignaturas where asignaturas.Carrera=1 and asignaturas.Facultad= facultades.Uid);
		
		set @num = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'NumeroPDF');
		set @num = @num + 1;
		update kumenya_biblioteca.configuracion set Valor = @num where NombreAtributo = 'NumeroPDF';
		
		set @notafeb = (select max(NotaPrimera) from matriculasasignaturas where UidMatricula = @mat);
		set @notajun = (select max(NotaSegunda) from matriculasasignaturas where UidMatricula = @mat);
		set @notaext = (select max(NotaExtraordinaria) from matriculasasignaturas where UidMatricula = @mat);
		if (@notaext >= 5) then
			set @convocatoria = (select distinct(SesionExtraordinaria) from matriculasasignaturas where UidMatricula = @mat);
			set @sesion = (select NombreAtributo from kumenya_biblioteca.configuracion where NombreAtributo ='SesionExtraordinaria');
		else
			if (@notajun >= 5) then
				set @convocatoria = (select distinct(SesionSegunda) from matriculasasignaturas where UidMatricula = @mat);
				set @sesion = (select NombreAtributo from kumenya_biblioteca.configuracion where NombreAtributo ='SesionSegunda');
			else
				set @convocatoria = (select distinct(SesionPrimera) from matriculasasignaturas where UidMatricula = @mat);
				set @sesion = (select NombreAtributo from kumenya_biblioteca.configuracion where NombreAtributo ='SesionPrimera');
			end if;
		end if;
		set @convocatoria =concat(@convocatoria, ' ');
		set @seleccion= concat( 'select concat_ws('' '', upper(Apellidos), concat(upper(substring(Nombre,1,1)) , lower(substring(Nombre, 2)))) as nombre, ',
							'localidades.Localidad as localidad, ',
							'year(FechaNacimiento) as anionacimiento, ''',
							@sesion,''' as sesion,',
							'concat(''',@convocatoria,''', ''',@anio, ''' ) as convocatoria,',
							' carreras.Carrera as carrera , ',
							'concat(''',@anio,''', ''-'', ''',@anio+1,''') as anioacademico, ',
							' now() as fecha, ',
							'(select valor from kumenya_biblioteca.configuracion where NombreAtributo = ''JefeEstudios'') as JefeEstudios, ',
							'(select valor from kumenya_biblioteca.configuracion where NombreAtributo = ''Rector'') as Rector ',
							' , ''',@facultad,''' as facultad',
							' , ''',@num, ''' as numero',
							' from personas, localidades, carreras '
							' where personas.Localidad = localidades.Uid and carreras.Uid = ', UidCarrier,' and personas.Uid= ', UidAlum, '; ');
		set @exito = 1;
		
	else
		if @sancionBiblio > 0 then
			set @seleccion = 'El alumno tiene sanciones pendientes de la biblioteca';
		else
			if @cuenta > 0 then
				set @seleccion = 'El alumno tiene pagos pendientes a la universidad';
			else
				if @asigCarrera = 0 then
					set @seleccion = 'La carrera no tiene asignaturas asociadas';
				else
					set @seleccion = 'El alumno no tiene aprobadas todas las asignaturas de la carrera';
				end if;
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `TEM`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `TEM`(UidAlum bigint(16), UidCarrier bigint(16), out exito int(11), out salida varchar(200), out seleccion varchar(400))
begin
	START TRANSACTION;
	set @exito = 0;
	set @PrimerCiclo = (select AniosPrimerCiclo from carreras where Uid = UidCarrier);
	set @sancionBiblio = (select count(1) from kumenya_biblioteca.prestamos where UidPersona = UidAlum and HaySancion = 'Si');
	set @cuenta = (select count(1) from kumenya_contabilidad.cuentascontables where UidTercero = UidAlum  and TipoTercero = 'Persona'  and Debe <> Haber);
	set @asigCarrera = (select count(1) from asignaturas where carrera = UidCarrier and curso <= @PrimerCiclo);
	set @asigAprobadas = (select count(1) from matriculasasignaturas, matriculas, asignaturas
							where matriculasasignaturas.UidMatricula = matriculas.Uid and matriculasasignaturas.UidAsignatura = asignaturas.Uid and
									matriculas.UidAlumno=UidAlum and asignaturas.Carrera = UidCarrier and matriculasasignaturas.NotaFinal >= 5.0 and asignaturas.Curso <= @PrimerCiclo);
	if (@sancionBiblio = 0 and @cuenta = 0 and @asigCarrera = @asigAprobadas and @asigCarrera > 0) then
		
		set @mat= (select max(matriculas.Uid)
					from matriculas, matriculasasignaturas, asignaturas
					where matriculas.Uid = matriculasasignaturas.UidAsignatura and
					matriculasasignaturas.UidAsignatura = asignaturas.Uid and
					asignaturas.Curso <= 3 and matriculas.UidAlumno =7);
		
		set @anio = (select distinct(Anio) from matriculas where Uid=@mat);
		
		set @notafeb = (select max(NotaPrimera) from matriculasasignaturas where UidMatricula = @mat);
		set @notajun = (select max(NotaSegunda) from matriculasasignaturas where UidMatricula = @mat);
		set @notaext = (select max(NotaExtraordinaria) from matriculasasignaturas where UidMatricula = @mat);
		if (@notaext >= 5) then
			set @convocatoria = (select distinct(SesionExtraordinaria) from matriculasasignaturas where UidMatricula = @mat);
			set @sesion = (select NombreAtributo from kumenya_biblioteca.configuracion where NombreAtributo ='SesionExtraordinaria');
		else
			if (@notajun >= 5) then
				set @convocatoria = (select distinct(SesionSegunda) from matriculasasignaturas where UidMatricula = @mat);
				set @sesion = (select NombreAtributo from kumenya_biblioteca.configuracion where NombreAtributo ='SesionSegunda');
			else
				set @convocatoria = (select distinct(SesionPrimera) from matriculasasignaturas where UidMatricula = @mat);
				set @sesion = (select NombreAtributo from kumenya_biblioteca.configuracion where NombreAtributo ='SesionPrimera');
			end if;
		end if;
		select concat_ws(' ', upper(Apellidos),
				 concat(upper(substring(Nombre,1,1)),  lower(substring(Nombre, 2)))
				) as nombre,
			localidades.Localidad as localidad,
			year(FechaNacimiento) as anionacimiento,
			@sesion as sesion,
			concat(@convocatoria, ' ',@anio) as convocatoria,
			carreras.Carrera as carrera ,
			concat(@anio, '-', @anio+1)  as anioacademico,
			now() as fecha,
			(select valor from kumenya_biblioteca.configuracion where NombreAtributo = 'JefeEstudios') as JefeEstudios,
			(select valor from kumenya_biblioteca.configuracion where NombreAtributo = 'Rector') as Rector
		from personas, localidades, carreras
		where
		personas.Localidad = localidades.Uid and carreras.Uid = UidCarrier and personas.Uid=UidAlum;
				set @exito = 1;
				set @salida = 'El alumno ha superado el primer ciclo';
	else
		if @sancionBiblio > 0 then
			set @salida = 'El alumno tiene sanciones pendientes de la biblioteca';
		else
			if @cuenta > 0 then
				set @salida = 'El alumno tiene pagos pendientes a la universidad';
			else
				if @asigCarrera = 0 then
					set @salida = 'La carrera no tiene asignaturas asociadas';
				else
					set @salida = 'El alumno no tiene aprobadas todas las asignaturas de la carrera';
				end if;
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida, @seleccion;
end$$

--
-- Funciones
--
DROP FUNCTION IF EXISTS `ControlDeCurso`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ControlDeCurso`(UidAlum bigint(16), UidCar bigint(16)) RETURNS varchar(100) CHARSET latin1
begin

  
  set @convalidacion = (select convalidada from matriculas where Uid = (select max(Uid) from matriculas left join matriculasasignaturas on UidMatricula = matriculas.Uid where UidAsignatura IN (select Uid from asignaturas where Carrera = UidCar) and UidAlumno = UidAlum));
  if (@convalidacion = 1) then
    return 'Pasas';
  end if;

  
	set @cursoActual = (select MAX(Curso) from asignaturas where Carrera=UidCar and Uid in (select UidAsignatura from matriculasasignaturas where UidMatricula  in  (select max(Uid) from matriculas where UidAlumno=UidAlum)));

  
  set @asignNoPresentadas = (select COUNT(Uid) from matriculasasignaturas RIGHT JOIN asignaturas on UidAsignatura = Uid where Carrera=UidCar and Vigente = 1 and Curso = @cursoActual and
		(NotaFinal is null and UidMatricula in (select max(Uid) from matriculas where UidAlumno=UidAlum)));
  if @asignNoPresentadas > 0 then
      return 'Repites';
    end if;

  
  set @asignSinMinimo = (select COUNT(Uid) from matriculasasignaturas RIGHT JOIN asignaturas on UidAsignatura = Uid where Carrera=UidCar and Curso = @cursoActual and Vigente = 1 and
		(NotaFinal < (select valor from kumenya_biblioteca.configuracion where NombreAtributo='CorteSuspenso') and UidMatricula in (select max(Uid) from matriculas where UidAlumno=UidAlum)));

  if @asignSinMinimo = 0 then
    
    set @porcentaje = (select valor from kumenya_biblioteca.configuracion where NombreAtributo='PorCientoAprobado');
  else
    if @asignSinMinimo = 1 then
      
      set @porcentaje = (select valor from kumenya_biblioteca.configuracion where NombreAtributo='PorCientoAprobadoComplemento');
    else
      
      return 'Repites';
    end if;
  end if;

  
  set @pond = (select sum(Ponderacion) from asignaturas where Carrera=UidCar and Vigente = 1 and Curso = @cursoActual and Uid in (select UidAsignatura from matriculasasignaturas where NotaFinal is not null and UidMatricula  in (select max(Uid) from matriculas where UidAlumno=UidAlum)));
  set @notaMaxima = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo='NotaMaxima');
  set @ponderacionCurso = @pond * @notaMaxima;

  
  set @ponderacionAlumno = (select SUM(Ponderacion * NotaFinal) from matriculasasignaturas RIGHT JOIN asignaturas on UidAsignatura = Uid where NotaFinal is not null and Carrera=UidCar and Curso = @cursoActual and Vigente = 1 and UidMatricula in (select max(Uid) from matriculas where UidAlumno=UidAlum));

  
  if (@ponderacionAlumno * 100) / @ponderacionCurso < @porcentaje then
    return 'Repites';
  end if;


  
  set @complementos = (select COUNT(Uid) from matriculasasignaturas RIGHT JOIN asignaturas on UidAsignatura = Uid where Carrera=UidCar and Vigente = 1 and Curso < @cursoActual and
		(notafinal < (select valor from kumenya_biblioteca.configuracion where NombreAtributo='Aprobado') and UidMatricula in (select max(Uid) from matriculas where UidAlumno=UidAlum)));

  if @asignSinMinimo + @complementos > 2 then
		set @salida = 'Repites';
	else
		set @salida = 'Pasas';
	end if;


	return @ponderacionAlumno;
end$$

DROP FUNCTION IF EXISTS `PorcentajeCurso`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `PorcentajeCurso`(Matr bigint(16)) RETURNS float(11,2)
BEGIN
  
	set @cursoActual = (select MAX(Curso) from asignaturas where Uid in (select UidAsignatura from matriculasasignaturas where UidMatricula = Matr));

  
  set @asignNoPresentadas = (select COUNT(Uid) from matriculasasignaturas RIGHT JOIN asignaturas on UidAsignatura = Uid where Vigente = 1 and Curso = @cursoActual and
		(NotaFinal is null and UidMatricula = Uid));
  if @asignNoPresentadas > 0 then
    return NULL;
  end if;

  
  set @pond = (select sum(Ponderacion) from asignaturas where Vigente = 1 and Curso = @cursoActual and Uid in (select UidAsignatura from matriculasasignaturas where NotaFinal is not null and UidMatricula = Matr));
  set @notaMaxima = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo='NotaMaxima');
  set @ponderacionCurso = @pond * @notaMaxima;

  
  set @ponderacionAlumno = (select SUM(Ponderacion * NotaFinal) from matriculasasignaturas RIGHT JOIN asignaturas on UidAsignatura = Uid where NotaFinal is not null and Curso = @cursoActual and UidMatricula = Matr);

  
  set @porcentaje = (@ponderacionAlumno * 100) / @ponderacionCurso;

  return @porcentaje;

END$$

DROP FUNCTION IF EXISTS `SiguienteCodigo`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `SiguienteCodigo`(tipoper enum ('Alumno','PAS','Profesor')) RETURNS varchar(10) CHARSET latin1
BEGIN
	if tipoper = 'Alumno' then
		set @codigo = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'UltimoCodigoAlumno');
		set @crit = 'UltimoCodigoAlumno';
	else
		if tipoper = 'PAS' then
			set @codigo = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'UltimoCodigoPAS');
			set @crit = 'UltimoCodigoPAS';
		else
			set @codigo = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'UltimoCodigoProfesor');
			set @crit = 'UltimoCodigoProfesor';
		end if;
	end if;
	set @inicio = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'FechaInicioCurso');
	if now() >= concat(year(@inicio) + 1,'-10-01') then
    set @tipo = mid(@codigo,1,1);
		set @siganio = right(concat('00',(mid(@codigo,2,2) + 1)),2);
		set @nuevo = concat(@tipo,@siganio,'0001');
		update kumenya_biblioteca.configuracion
			set Valor = concat(year(@inicio) + 1,'-10-01')
		where
			NombreAtributo='FechaInicioCurso';
  else
  	set @tipo = mid(@codigo,1,3);
	  set @sigcod = mid(@codigo,4,4) + 1;
  	set @sigcodigo = right(concat('0000',@sigcod),4);
	  set @nuevo = concat(@tipo,@sigcodigo);
	end if;
	update kumenya_biblioteca.configuracion set Valor = @nuevo where NombreAtributo = @crit;
	return @nuevo;
END$$

DROP FUNCTION IF EXISTS `SiguienteCuenta`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `SiguienteCuenta`(tipoper enum('Alumno','PAS','Profesor'), visita enum('No','Si')) RETURNS varchar(20) CHARSET latin1
BEGIN
	if tipoper = 'Alumno' then
		set @numcuenta = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'UltimaCuentaAlumno');
		set @padre = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'CuentaPadreAlumnos');
		set @crit = 'UltimaCuentaAlumno';
	else
		if (tipoper = 'PAS') or ((tipoper = 'Profesor') and (visita = 'No')) then
			set @numcuenta = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'UltimaCuentaPersonal');
			set @padre = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'CuentaPadrePersonal');
			set @crit = 'UltimaCuentaPersonal';
		else
			if (tipoper = 'Profesor') and (visita = 'Si') then
				set @numcuenta = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'UltimaCuentaProfesorVisitante');
				set @padre = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'CuentaPadreProfesorVisitante');
				set @crit = 'UltimaCuentaProfesorVisitante';
			end if;
		end if;
	end if;
	set @sigcod = concat(@padre,'.',(@numcuenta + 1));
	update kumenya_biblioteca.configuracion
		set Valor = @numcuenta + 1
	where
		NombreAtributo=@crit;
	return @sigcod;
END$$

DROP FUNCTION IF EXISTS `ValidarAlumno`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarAlumno`(FechaNac varchar(10), AnioBach varchar(10)) RETURNS varchar(100) CHARSET latin1
BEGIN
	set @fec = 1;
	set @anio = 1;
	if FechaNac is not null then
		set @fec = ValidarFecha(FechaNac);
	end if;
	if AnioBach is not null then
		set @anio = ValidarAnio(AnioBach);
	end if;
	set @resul = ' ';
	if (@fec * @anio = 0) then
		set @resul = 'Información no correcta: ';
		if @fec = 0 then
			set @resul = concat(@resul, "'", FechaNac, "' ");
		end if;
		if @anio = 0 then
			set @resul = concat(@resul, "'", AnioBach, "' ");
		end if;
	end if;
	return @resul;
END$$

DROP FUNCTION IF EXISTS `ValidarAnio`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarAnio`(entrada varchar(20)) RETURNS int(11)
BEGIN
	if @anito < 0 then
		return 0;
	else
		set @anito = cast(entrada as unsigned);
		if @anito then
			if (@anito > 0 and @anito <= 2155) then
				return 1;
			else
				return 0;
			end if;
		else
			return 0;
		end if;
	end if;
END$$

DROP FUNCTION IF EXISTS `ValidarFecha`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarFecha`(entrada varchar(20)) RETURNS int(11)
BEGIN
	set @fecha=str_to_date(entrada,'%Y-%m-%d');
	if cast(@fecha as date)  then
		return 1;
	else
		return 0;
	end if;
END$$

DROP FUNCTION IF EXISTS `ValidarNull`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarNull`(entrada varchar(100)) RETURNS int(11)
BEGIN
	if entrada is null then
		return 0;
	else
		return 1;
	end if;
END$$

DROP FUNCTION IF EXISTS `ValidarNullAltaAlumno`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarNullAltaAlumno`(Nombre varchar(50), Apellidos varchar(50), NumIdentificacion varchar(20), FechaNacimiento varchar(10), Nacionalidad int, LugarNacimiento varchar(100), Direccion varchar(200), Poblacion varchar(100), Provincia varchar(100), Pais int) RETURNS varchar(400) CHARSET latin1
BEGIN
	set @nom = ValidarNull(Nombre);
	set @ape = ValidarNull(Apellidos);
	set @num = ValidarNull(NumIdentificacion);
	set @fec = ValidarNull(FechaNacimiento);
	set @nac = ValidarNull(Nacionalidad);
	set @lug = ValidarNull(LugarNacimiento);
	set @dir = ValidarNull(Direccion);
	set @pob = ValidarNull(Poblacion);
	set @pro = ValidarNull(Provincia);
	set @pai = ValidarNull(Pais);
	set @resul = ' ';
	set @uid = (select Uid from procedimientos where Nombre='AltaDePersona');
	if (@nom * @ape * @num * @fec * @nac * @lug * @dir * @pob * @pro * @pai  = 0) then
		set @resul ="Campos obligatorios sin informacion: ";
		if @nom = 0 then
			set @campo = (select Nombre from parametros where UidProc =@uid   and Orden = 1);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @ape = 0 then
			set @campo = (select Nombre from parametros where UidProc =@uid and Orden = 2);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @num = 0 then
			set @campo = (select Nombre from parametros where UidProc = @uid and Orden = 3);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @fec = 0 then
			set @campo = (select Nombre from parametros where UidProc = @uid and Orden = 4);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @nac = 0 then
			set @campo = (select Nombre from parametros where UidProc = @uid and Orden = 5);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @lug = 0 then
			set @campo = (select Nombre from parametros where UidProc = @uid and Orden = 6);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @dir = 0 then
			set @campo = (select Nombre from parametros where UidProc = @uid and Orden = 7);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @pob = 0 then
			set @campo = (select Nombre from parametros where UidProc = @uid and Orden = 8);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @pro = 0 then
			set @campo = (select Nombre from parametros where UidProc = @uid and Orden = 10);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @pai = 0 then
			set @campo = (select Nombre from parametros where UidProc = @uid and Orden = 11);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
	end if;
	return @resul;
END$$

DROP FUNCTION IF EXISTS `ValidarNullAltaAsignatura`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarNullAltaAsignatura`(asig varchar(150), cur int(5), depart varchar(150), car int(5), vig enum('Si','No'), pond int(5)) RETURNS varchar(400) CHARSET latin1
BEGIN
	set @resul = ' ';

	if (isnull(asig)  or  isnull(cur) or isnull(depart) or isnull(car) or isnull(vig) or isnull(pond)) then
		set @resul ="Campos obligatorios sin informacion: ";
		if isnull(asig) then
			set @campo = (select Nombre from kumenya_matriculacion.parametros where UidProc = (select Uid from kumenya_matriculacion.procedimientos where Nombre='AltaDeAsignatura')  and Orden = 1);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if  isnull(cur) then
			set @campo = (select Nombre from kumenya_matriculacion.parametros where UidProc = (select Uid from kumenya_matriculacion.procedimientos where Nombre = 'AltaDeAsignatura') and Orden = 5);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if  isnull(depart) then
			set @campo = (select Nombre from kumenya_matriculacion.parametros where UidProc = (select Uid from kumenya_matriculacion.procedimientos where Nombre = 'AltaDeAsignatura') and Orden = 6);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if isnull(car) then
			set @campo = (select Nombre from kumenya_matriculacion.parametros where UidProc = (select Uid from kumenya_matriculacion.procedimientos where Nombre = 'AltaDeAsignatura') and Orden = 7);
			set @resul = concat(@resul,"'", @campo, "' ");
		end if;
		if isnull(vig) then
			set @campo = (select Nombre from kumenya_matriculacion.parametros where UidProc = (select Uid from kumenya_matriculacion.procedimientos where Nombre = 'AltaDeAsignatura') and Orden = 11);
			set @resul = concat(@resul,"'", @campo, "' ");
		end if;
		if isnull(pond) then
			set @campo = (select Nombre from kumenya_matriculacion.parametros where UidProc = (select Uid from kumenya_matriculacion.procedimientos where Nombre = 'AltaDeAsignatura') and Orden = 10);
			set @resul = concat(@resul,"'", @campo, "' ");
		end if;
	end if;
	return @resul;
END$$

DROP FUNCTION IF EXISTS `ValidarNullAltaPersona`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarNullAltaPersona`(Nomb varchar(50), Apellid varchar(50), CodPer varchar(10), TipoPer enum('Alumno','PAS','Profesor'), NumIden varchar(20)) RETURNS varchar(400) CHARSET latin1
BEGIN
	set @resul = ' ';
	if (isnull(Nomb)  or  isnull(Apellid) or isnull(CodPer) or isnull(TipoPer) or isnull(NumIden)) then
		set @resul ="Campos obligatorios sin informacion: ";
		if isnull(Nomb) then
			set @campo = (select Nombre from kumenya_matriculacion.parametros where UidProc = (select Uid from kumenya_matriculacion.procedimientos where Nombre='AltaDeAlumno')  and Orden = 1);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if  isnull(Apellid) then
			set @campo = (select Nombre from kumenya_matriculacion.parametros where UidProc = (select Uid from kumenya_matriculacion.procedimientos where Nombre = 'AltaDeAlumno') and Orden = 2);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if  isnull(CodPer) then
			set @campo = (select Nombre from kumenya_matriculacion.parametros where UidProc = (select Uid from kumenya_matriculacion.procedimientos where Nombre = 'AltaDeAlumno') and Orden = 3);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if isnull(TipoPer) then
			set @campo = (select Nombre from kumenya_matriculacion.parametros where UidProc = (select Uid from kumenya_matriculacion.procedimientos where Nombre = 'AltaDeAlumno') and Orden = 4);
			set @resul = concat(@resul,"'", @campo, "' ");
		end if;
		if isnull(NumIden) then
			set @campo = (select Nombre from kumenya_matriculacion.parametros where UidProc = (select Uid from kumenya_matriculacion.procedimientos where Nombre = 'AltaDeAlumno') and Orden = 5);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
	end if;
	return @resul;
END$$

DROP FUNCTION IF EXISTS `ValidarNullModificacionPersona`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarNullModificacionPersona`(Id bigint, Nombr varchar(50), Apellid varchar(50), CodPer varchar(10), TipoPer enum ('Alumno','PAS','Profesor'), NumId varchar(20)) RETURNS varchar(500) CHARSET latin1
BEGIN
	set @resul = ValidarNullAltaPersona(Nombr,Apellid,CodPer,TipoPer,NumId);
	set @id = ValidarNull(Id);
	if @id = 0 then
		set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre ='ModificacionDeAlumno') and Orden = 1);
		if @resul <> ' ' then
			set @resul = concat(trim(@resul), " '", @campo, "'");
		else
			set @resul = trim(concat("'Campos obligatorios sin informacion: ", "'", @campo, "' "));
		end if;
	else
		set @resul = ' ';
	end if;
	return @resul;
END$$

DELIMITER ;

--
-- Base de datos: `kumenya_biblioteca`
--
CREATE DATABASE kumenya_biblioteca DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE kumenya_biblioteca;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulos`
--

DROP TABLE IF EXISTS `articulos`;
CREATE TABLE IF NOT EXISTS `articulos` (
  `Uid` bigint(16) unsigned zerofill NOT NULL COMMENT 'identificador indexado de documentos',
  `Autor` varchar(80) NOT NULL COMMENT 'autor del articulo',
  `NombreFuente` varchar(100) NOT NULL COMMENT 'nombre del periodico o revista donde se encuentra el articulo',
  `Fasciculo` int(11) default NULL COMMENT 'fasciculo de la fuente',
  `Pagina` int(11) NOT NULL COMMENT 'pagina donde se encuentra el articulo',
  `CodigoFuente` varchar(14) NOT NULL COMMENT 'codigo de la revista o el periodico',
  PRIMARY KEY  (`Uid`),
  KEY `art_ind` (`Autor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clavesexternas`
--

DROP TABLE IF EXISTS `clavesexternas`;
CREATE TABLE IF NOT EXISTS `clavesexternas` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Tabla` varchar(45) NOT NULL,
  `Columna` varchar(45) NOT NULL,
  `TablaReferencia` varchar(45) NOT NULL,
  `Clave` varchar(45) NOT NULL,
  `Valor` varchar(45) NOT NULL,
  `Ambito` varchar(45) NOT NULL,
  `Buscar` enum('YES','NO') NOT NULL default 'NO',
  PRIMARY KEY  (`Uid`),
  UNIQUE KEY `UnicaClaveExterna` USING BTREE (`Tabla`,`Columna`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

DROP TABLE IF EXISTS `configuracion`;
CREATE TABLE IF NOT EXISTS `configuracion` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment COMMENT 'Identificador',
  `NombreAtributo` varchar(80) NOT NULL COMMENT 'Nombre del parametro',
  `Valor` varchar(80) NOT NULL COMMENT 'Valor del parametro',
  `Modificable` enum('No','Si') NOT NULL,
  PRIMARY KEY  USING BTREE (`Uid`),
  KEY `In_Nombre` (`NombreAtributo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=44 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos`
--

DROP TABLE IF EXISTS `documentos`;
CREATE TABLE IF NOT EXISTS `documentos` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment COMMENT 'Identificador del libro, articulo, periodico o revista',
  `Titulo` varchar(100) NOT NULL COMMENT 'Titulo del documento',
  `Signatura` varchar(14) NOT NULL COMMENT 'Indica el lugar fisico donde se encuentra el libro en la biblioteca',
  `Volumen` varchar(15) default NULL COMMENT 'Volumen de la publicacion',
  `Observaciones` varchar(100) default NULL COMMENT 'Comentarios',
  `Traductor` varchar(50) default NULL COMMENT 'Persona que ha traducido el libro',
  `PalabrasClave` varchar(200) default NULL,
  `Idioma` int(3) unsigned NOT NULL,
  `Estado` int(3) unsigned NOT NULL,
  `Activo` bit(1) NOT NULL COMMENT 'Permite dar de baja documentos sin borrarlos de la base de datos',
  `FechaCreacion` datetime NOT NULL COMMENT 'Fecha de alta del documento en la base de datos',
  `FechaModificacion` datetime NOT NULL COMMENT 'Fecha de la ultima modificacion del documento en la base de datos',
  `FechaBaja` datetime default NULL COMMENT 'Fecha de baja del documento en la base de datos',
  PRIMARY KEY  (`Uid`),
  KEY `FK_doc_idi` (`Idioma`),
  KEY `FK_doc_tit` (`Titulo`),
  KEY `FK_doc_palcla` (`PalabrasClave`),
  KEY `FK_doc_est` (`Estado`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1773 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados`
--

DROP TABLE IF EXISTS `estados`;
CREATE TABLE IF NOT EXISTS `estados` (
  `Estado` int(3) unsigned NOT NULL auto_increment,
  `Valor` varchar(14) NOT NULL,
  PRIMARY KEY  (`Estado`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `idiomas`
--

DROP TABLE IF EXISTS `idiomas`;
CREATE TABLE IF NOT EXISTS `idiomas` (
  `Clave` int(3) unsigned NOT NULL auto_increment COMMENT 'Identificador',
  `Valor` varchar(14) NOT NULL COMMENT 'Idioma',
  PRIMARY KEY  (`Clave`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libros`
--

DROP TABLE IF EXISTS `libros`;
CREATE TABLE IF NOT EXISTS `libros` (
  `Uid` bigint(16) unsigned zerofill NOT NULL COMMENT 'Uid que coincide con el uid de documento',
  `Autor` varchar(80) NOT NULL COMMENT 'Autor del libro',
  `DireccionPub` varchar(100) default NULL,
  `Editorial` varchar(50) default NULL,
  `Procedencia` varchar(100) default NULL COMMENT 'uid que coincide con el uid de la tabla documentos',
  `ISBN` varchar(25) default NULL,
  PRIMARY KEY  (`Uid`),
  KEY `FK_libr` (`Autor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parametros`
--

DROP TABLE IF EXISTS `parametros`;
CREATE TABLE IF NOT EXISTS `parametros` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Nombre` varchar(100) NOT NULL,
  `Orden` int(10) unsigned NOT NULL,
  `UidProc` bigint(16) unsigned NOT NULL,
  `Tipo` enum('IN','OUT','INOUT') NOT NULL,
  `TipoDatos` varchar(100) default NULL,
  `ConsultaQuery` varchar(500) default NULL,
  PRIMARY KEY  (`Uid`),
  UNIQUE KEY `ParametroUnico` (`Nombre`,`UidProc`),
  UNIQUE KEY `OrdenUnico` USING BTREE (`Orden`,`UidProc`),
  KEY `FK_parametros_procedimientos` (`UidProc`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=795 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos`
--

DROP TABLE IF EXISTS `prestamos`;
CREATE TABLE IF NOT EXISTS `prestamos` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `UidDocumento` bigint(16) unsigned zerofill NOT NULL,
  `UidPersona` bigint(16) unsigned zerofill NOT NULL,
  `FechaInicio` date NOT NULL,
  `FechaFin` date NOT NULL,
  `FechaDevolucion` date default NULL,
  `HaySancion` enum('Si','No') NOT NULL default 'No',
  `Activo` bit(1) NOT NULL,
  `FechaCreacion` datetime NOT NULL,
  `FechaModificacion` datetime NOT NULL,
  `FechaBaja` datetime default NULL,
  PRIMARY KEY  (`Uid`),
  KEY `FK_prestamos_personas` (`UidPersona`),
  KEY `UidDocumento` (`UidDocumento`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `procedimientos`
--

DROP TABLE IF EXISTS `procedimientos`;
CREATE TABLE IF NOT EXISTS `procedimientos` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Nombre` varchar(100) NOT NULL,
  PRIMARY KEY  (`Uid`),
  UNIQUE KEY `NombreUnico` (`Nombre`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=123 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

DROP TABLE IF EXISTS `reservas`;
CREATE TABLE IF NOT EXISTS `reservas` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `UidDocumento` bigint(16) unsigned zerofill NOT NULL,
  `UidPersona` bigint(16) unsigned zerofill NOT NULL,
  `FechaInicio` date NOT NULL,
  `Activo` bit(1) NOT NULL,
  `FechaCreacion` datetime NOT NULL,
  `FechaModificacion` datetime NOT NULL,
  `FechaBaja` datetime default NULL,
  PRIMARY KEY  USING BTREE (`Uid`),
  KEY `FK_reserva_personas` (`UidPersona`),
  KEY `UNICA_RESERVA` (`UidDocumento`,`UidPersona`,`FechaInicio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `revistasperiodicos`
--

DROP TABLE IF EXISTS `revistasperiodicos`;
CREATE TABLE IF NOT EXISTS `revistasperiodicos` (
  `Uid` bigint(16) unsigned zerofill NOT NULL COMMENT 'Identificador',
  `Editor` varchar(50) default NULL COMMENT 'Editor de la revista',
  `Numero` int(11) NOT NULL COMMENT 'Numero de periodico de la revista',
  `DireccionPub` varchar(100) default NULL COMMENT 'DireccionPub del editor',
  `FechaSuscripcion` date default NULL COMMENT 'Fecha de suscripcion',
  `Frecuencia` int(11) NOT NULL COMMENT 'Frecuencia de la publicacion en dias',
  `Fasciculo` int(11) default NULL COMMENT 'Fasciculo del periodico o la revista',
  `AnioPub` year(4) NOT NULL COMMENT 'Año de la publicacion',
  `EsRevista` enum('Periodico','Revista') NOT NULL COMMENT 'Verdadero si es una revista y falso en caso contrario',
  PRIMARY KEY  (`Uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 PACK_KEYS=1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sanciones`
--

DROP TABLE IF EXISTS `sanciones`;
CREATE TABLE IF NOT EXISTS `sanciones` (
  `Id` int(16) unsigned NOT NULL auto_increment COMMENT 'Identificador',
  `Fecha` datetime NOT NULL COMMENT 'Fecha de inicio de la sancion',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposanciones`
--

DROP TABLE IF EXISTS `tiposanciones`;
CREATE TABLE IF NOT EXISTS `tiposanciones` (
  `Clave` int(3) unsigned NOT NULL auto_increment COMMENT 'Identificador',
  `Valor` varchar(14) NOT NULL COMMENT 'Cantidad a pagar por un dia de retraso',
  PRIMARY KEY  (`Clave`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Usuario` varchar(45) NOT NULL,
  `Contrasena` varchar(45) NOT NULL,
  `Persona` bigint(16) unsigned zerofill NOT NULL,
  `TipoUsuario` enum('Contable','Administrativo','TEDECO','Profesor','Decano','Bibliotecario') NOT NULL,
  `Activo` bit(1) NOT NULL,
  `FechaCreacion` datetime NOT NULL,
  `FechaModificacion` datetime NOT NULL,
  `FechaBaja` datetime default NULL,
  PRIMARY KEY  (`Uid`),
  KEY `usuarios_personas` (`Persona`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=26 ;

--
-- Filtros para las tablas descargadas (dump)
--

--
-- Filtros para la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD CONSTRAINT `FK_articulos_documentos` FOREIGN KEY (`Uid`) REFERENCES `documentos` (`Uid`);

--
-- Filtros para la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD CONSTRAINT `FK_doc_est` FOREIGN KEY (`Estado`) REFERENCES `estados` (`Estado`),
  ADD CONSTRAINT `FK_doc_idi` FOREIGN KEY (`Idioma`) REFERENCES `idiomas` (`Clave`);

--
-- Filtros para la tabla `libros`
--
ALTER TABLE `libros`
  ADD CONSTRAINT `FK_libros_documentos` FOREIGN KEY (`Uid`) REFERENCES `documentos` (`Uid`);

--
-- Filtros para la tabla `parametros`
--
ALTER TABLE `parametros`
  ADD CONSTRAINT `FK_parametros_procedimientos` FOREIGN KEY (`UidProc`) REFERENCES `procedimientos` (`Uid`);

--
-- Filtros para la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD CONSTRAINT `prestamos_ibfk_1` FOREIGN KEY (`UidDocumento`) REFERENCES `documentos` (`Uid`),
  ADD CONSTRAINT `prestamos_ibfk_3` FOREIGN KEY (`UidPersona`) REFERENCES `kumenya_matriculacion`.`personas` (`Uid`);

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `FK_reserva_document` FOREIGN KEY (`UidDocumento`) REFERENCES `documentos` (`Uid`),
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`UidPersona`) REFERENCES `kumenya_matriculacion`.`personas` (`Uid`);

--
-- Filtros para la tabla `revistasperiodicos`
--
ALTER TABLE `revistasperiodicos`
  ADD CONSTRAINT `FK_revistasperiodicos_documentos` FOREIGN KEY (`Uid`) REFERENCES `documentos` (`Uid`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`Persona`) REFERENCES `kumenya_matriculacion`.`personas` (`Uid`);

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `AltaDeArticulo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeArticulo`(Titulo varchar(500), Signatura varchar(14), Volumen varchar(15), Observaciones varchar(100), Traductor varchar(50), PalabrasClave varchar(200), Idioma int, Estado int, Autor varchar(80), NombreFuente varchar(100), Fasciculo varchar(10), Pagina varchar(10), CodigoFuente varchar(14), OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	if (Titulo is null)  or (Signatura is null) or (Idioma is null) or (Estado is null) or (Autor is null) or (NombreFuente is null) or (Pagina is null) or (CodigoFuente is null) then
		set @exito = 0;
		set @vacios = ValidarNullAltaArticulo(Titulo, Signatura, Idioma, Estado, Autor, NombreFuente, Pagina, CodigoFuente);
		set @tipos = ValidarArticulo(Fasciculo, Pagina);
		set @salida = concat(trim(@vacios), '. ', trim(@tipos));
	else
		set @salida = ' ';
		set @salida = ValidarArticulo(Fasciculo, Pagina);
		if @salida <> ' ' then
			set @exito = 0;
			set @salida = trim(salida);
		else
			if Estado = 1 then
				call AltaDeDocumento(Titulo, Signatura, Volumen, Observaciones, Traductor, PalabrasClave, Idioma, Estado);
				SET @Uid = LAST_INSERT_ID();
				INSERT INTO articulos (Uid, Autor, NombreFuente, Fasciculo, Pagina, CodigoFuente) VALUES (@Uid, Autor, NombreFuente, Fasciculo, Pagina, CodigoFuente);
				set @salida = 'Se ha creado el registro';
				set @exito = 1;
			else
				set @exito = 0;
				set @salida = 'Estado no permitido';
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `AltaDeDocumento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeDocumento`(Titulo varchar(500), Signatura varchar(14), Volumen varchar(15), Observaciones varchar(100), Traductor varchar(50), PalabrasClave varchar(200), Idioma integer, Estado integer)
BEGIN
	INSERT INTO documentos (Titulo, Signatura, Volumen, Observaciones, Traductor, PalabrasClave, Idioma, Estado, Activo, FechaCreacion, FechaModificacion) VALUES (Titulo, Signatura, Volumen, Observaciones, Traductor, PalabrasClave, Idioma, Estado, 1, NOW(), NOW());
END$$

DROP PROCEDURE IF EXISTS `AltaDeLibro`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeLibro`(Titulo varchar(500), Signatura varchar(14), Volumen varchar(15), Observaciones varchar(100), Traductor varchar(50), PalabrasClave varchar(200), Idioma integer, Estado integer, Autor varchar(80), DireccionPub varchar(100), Editorial varchar(80), Procedencia varchar(100), ISBN varchar(25), OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	if (Titulo is null)  or (Signatura is null) or (Idioma is null) or (Estado is null) or (Autor is null) then
		set @exito = 0;
		set @salida = trim(ValidarNullAltaLibro(Titulo, Signatura, Idioma, Estado, Autor));
	else
		if Estado = 1 then
			call AltaDeDocumento(Titulo, Signatura, Volumen, Observaciones, Traductor, PalabrasClave, Idioma, Estado);
			SET @Uid = LAST_INSERT_ID();
			INSERT INTO libros (Uid, Autor, DireccionPub, Editorial, Procedencia, ISBN) VALUES (@Uid, Autor, DireccionPub, Editorial, Procedencia, ISBN);
			set @exito = 1;
			set @salida = 'Se ha creado el registro';
		else
			set @exito = 0;
			set @salida = 'Estado no permitido';
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `AltaDePrestamo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDePrestamo`(document bigint, person bigint, out exito int(11), out salida varchar(200))
BEGIN
	START TRANSACTION;
	set @per = (select count(*) from prestamos where Activo = 1 and HaySancion = 'Si' and UidPersona = person);
	set @personaReserva = (select UidPersona from reservas where UidDocumento = document ORDER BY FechaCreacion LIMIT 1);
	set @estado = (select Estado from documentos where Uid= document);
	set @numMax = ((select Valor from configuracion where NombreAtributo ='TiempoSolicita') - (select count(*) from prestamos where UidPersona = person and Activo=1));
	if ((@per = 0) and (@numMax > 0) and (@estado = 1) and (@personaReserva is null)) or ((@per = 0) and (@numMax > 0) and (@personaReserva = person) and (@estado = 3 or @estado = 1)) then
		INSERT INTO prestamos (UidDocumento, UidPersona, FechaInicio, FechaFin, Activo, FechaCreacion, FechaModificacion)
		VALUES (document, person, now(),date_add(now(), interval (select Valor from configuracion where NombreAtributo = 'TiempoPrestamo') day),1, now(), now());
		if (@personaReserva > 0 ) then
			delete from reservas where UidPersona = person and UidDocumento = document;
		end if;
		UPDATE documentos
			set Estado=2
		WHERE Uid= document;
		set @exito =1;
		set @salida = 'Préstamo realizado';
	else
		if (@per > 0) then
			set @salida= 'El usuario tiene una sanción pendiente';
		else
			if (@personaReserva is not null) and (@personaReserva <> person) then
				set @salida= 'Documento reservado por otro usuario';
			else
				if (@numMax = 0) then
					set @salida = 'El usuario tiene el número máximo de préstamos posibles';
				else
					if (@estado = 2) then
						set @salida = 'El documento está prestado';
					else
						set @salida = 'El estado del documento no permite que sea prestado';
					end if;
				end if;
			end if;
		end if;
		set @exito = 0;
	end if;
	if @exito = 0 then
		ROLLBACK;
	else
		COMMIT;
	end if;
	select @exito, @salida;
END$$

DROP PROCEDURE IF EXISTS `AltaDeReserva`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeReserva`(document bigint, person bigint, out exito int(11), out salida varchar(200))
BEGIN
	START TRANSACTION;
	set @per = (select count(*) from prestamos where Activo = 1 and HaySancion = 1 and UidPersona = person);
	set @doc = (select count(*) from prestamos where UidDocumento = document and Activo=1);
	set @num = (select count(*) from reservas where UidDocumento = document and UidPersona = person) + (select count(*) from prestamos where UidDocumento = document and UidPersona = person and Activo=1);
	set @estado = (select Estado from documentos where Uid= document);
	if ((@per = 0) and ((@doc > 0) or (@estado = 3)) and (@num = 0)) then
		INSERT INTO reservas (UidDocumento, UidPersona, FechaInicio, Activo, FechaCreacion, FechaModificacion)
		VALUES (document, person, now(), 1, now(), now());
		set @exito = 1;
		set @salida = 'Reserva realizada';
	else
		if (@per > 0) then
			set @salida= 'El usuario tiene una sanción pendiente';
			set @exito = 0;
		else
			if (@num > 0) then
				set @salida= 'Documento reservado o prestado por el usuario';
				set @exito = 0;
			else
				if (@estado=1) then
					set @salida= 'No se puede reservar. El documento está disponible para el préstamo';
					set @exito = 0;
				else
					set @salida= 'El estado del documento no permite que sea prestado';
					set @exito = 0;
				end if;
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
END$$

DROP PROCEDURE IF EXISTS `AltaDeRevista`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeRevista`(Titulo varchar(100), Signatura varchar(14), Volumen varchar(15), Observaciones varchar(100), Traductor varchar(50), PalabrasClave varchar(200),Idioma int, Estado int, Editor varchar(80), Numero varchar(10), DireccionPub varchar(100), FechaSuscripcion varchar(15), Frecuencia varchar(10), Fasciculo varchar(10), AnioPub varchar(10), EsRevista enum('Revista','Periodico'), OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	if (Titulo is null)  or (Signatura is null) or (Idioma is null) or (Estado is null) or (Numero is null) or (Frecuencia is null) or (AnioPub is null) or (EsRevista is null) then
		set @exito = 0;
		set @vacios = ValidarNullAltaRevista(Titulo, Signatura, Idioma, Estado, Numero, Frecuencia, AnioPub, EsRevista);
		set @tipos = ValidarRevista(Numero, FechaSuscripcion, Frecuencia, Fasciculo, AnioPub);
		set @salida = concat(trim(@vacios), '. ', trim(@tipos));
	else
		set @salida = ' ';
		set @salida = ValidarRevista(Numero, FechaSuscripcion, Frecuencia, Fasciculo, AnioPub);
		if @salida <> ' ' then
			set @exito = 0;
			set @salida = trim(salida);
		else
			if Estado = 1 then
				call AltaDeDocumento(Titulo, Signatura, Volumen, Observaciones, Traductor, PalabrasClave,Idioma, Estado);
				SET @Uid = LAST_INSERT_ID();
				set @fechasus = str_to_date(cast(FechaSuscripcion as char),'%Y-%m-%d');
				INSERT INTO revistasperiodicos (Uid, Editor, Numero, DireccionPub, FechaSuscripcion, Frecuencia, Fasciculo, AnioPub, EsRevista) VALUES (@Uid, Editor, Numero, DireccionPub, @fechasus, Frecuencia, Fasciculo, AnioPub, EsRevista);
				set @exito = 1;
				set @salida = 'Se ha creado el registro';
			else
				set @exito = 0;
				set @salida = 'Estado no permitido';
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `AltaDeUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeUsuario`(usuar varchar(45), pass varchar(45), person bigint(16), tipousuar enum ('Contable','Administrativo','TEDECO','Profesor','Decano','Bibliotecario'), out exito int(11), out salida varchar(100))
BEGIN
	START TRANSACTION;
	if (usuar is null) or (pass is null) or (person is null) or (tipousuar is null) then
		set @exito = 0;
		set @salida = ValidarNullAltaUsuario (usuar, pass, person, tipousuar);
	else
		set @per = (select Uid from kumenya_matriculacion.personas where Uid = person and Activo = 1);
		if (@per is null) then
			set @salida = 'No existe la persona seleccionada';
			set @exito = 0;
		else
			if (select count(*) from usuarios where Usuario = usuar and TipoUsuario = tipousuar and Activo = 1) > 0 then
				set @salida = 'Ya existe el usuario y el rol seleccionados';
				set @exito = 0;
			else
				insert into usuarios (Usuario, Contrasena, Persona, TipoUsuario, Activo, FechaCreacion, FechaModificacion) values (usuar, pass, person, tipousuar, 1, now(), now());
				set @exito = 1;
				set @salida = 'Se ha creado el registro';
			end if;
		end if;
	end if;
	if (@exito = 0) then
		ROLLBACK;
	else
		COMMIT;
	end if;
	select @exito, @salida;
END$$

DROP PROCEDURE IF EXISTS `AnualBiblioteca`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AnualBiblioteca`()
begin
	START TRANSACTION;
	set @exito = 0;
	set @salida = 'Fallo en el proceso, por favor, inténtelo de nuevo';
	
	delete from libros where Uid in (select Uid from documentos where activo = 0);
	delete from revistasperiodicos where Uid in (select Uid from documentos where activo = 0);
	delete from articulos where Uid in (select Uid from documentos where activo = 0);
	delete from documentos where Activo = 0;
	
	delete from prestamos where Activo = 0 and HaySancion = 'No';
	
	update prestamos
		set FechaModificacion = now();
	set @exito = 1;
	set @salida = 'Proceso realizado con éxito';
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `AnualContabilidad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AnualContabilidad`()
begin
	START TRANSACTION;
	set @exito = 0;
	
	
	
end$$

DROP PROCEDURE IF EXISTS `ArticulosPrestadosA`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ArticulosPrestadosA`(Id bigint(16), out exito int(11), out salida varchar(100), out cantidad int(11), out sele varchar(900))
BEGIN
	set @exito = 1;
	set @salida = 'Los artículos prestados son';
	if Id is null then
		set @exito = 0;
		set @salida = 'Tiene que elegir a una persona';
		set @cantidad = 0;
		set @sele = 'select * from documentos where false';
	else
		set @cantidad = (select count(*) from documentos, kumenya_matriculacion.personas, prestamos, articulos where documentos.Uid = articulos.Uid and articulos.Uid = prestamos.UidDocumento and kumenya_matriculacion.personas.Uid=Id and prestamos.UidPersona=Id);
		set @sele =concat( 'select documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos, articulos where documentos.Uid = articulos.Uid and articulos.Uid=prestamos.UidDocumento and kumenya_matriculacion.personas.Uid=',Id,' and prestamos.UidPersona=',Id);
	end if;
	select @exito, @salida, @cantidad, @sele;
END$$

DROP PROCEDURE IF EXISTS `ArticulosPrestadosDurante`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ArticulosPrestadosDurante`(fecini varchar(15), fecfin varchar(15), out exito int(11), out salida varchar(100), out cantidad int(11), out sele varchar(900))
BEGIN
	set @exito = 1;
	set @cantidad = 0;
	set @salida = 'Los artículos prestados son';
	if (fecini is null) and (fecfin is null) then
		set @cantidad = (select count(*) from documentos, kumenya_matriculacion.personas, prestamos, articulos where documentos.Uid = articulos.Uid and articulos.Uid = prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona);
		set @sele = 'select documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos, articulos where documentos.Uid = articulos.Uid and articulos.Uid=prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona';
	else
		if (fecini is not null) and (fecfin is null) then
			set @valini = ValidarFecha(fecini);
			if @valini = 0 then
				set @salida = 'La fecha de inicio no es válida';
			else
				set @cantidad = (select count(*) from documentos, kumenya_matriculacion.personas, prestamos, articulos where documentos.Uid = articulos.Uid and articulos.Uid = prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.FechaInicio >= fecini);
				set @sele = concat("select documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos, articulos where documentos.Uid = articulos.Uid and articulos.Uid=prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.FechaInicio >='", fecini,"'");
			end if;
		else
			if (fecini is null) and (fecfin is not null) then
				set @valfin = ValidarFecha(fecfin);
				if @valfin = 0 then
					set @salida = 'La fecha de fin no es válida';
				else
					set @cantidad = (select count(*) from documentos, kumenya_matriculacion.personas, prestamos, articulos where documentos.Uid = articulos.Uid and articulos.Uid = prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.FechaFin <= fecfin);
					set @sele =concat("select documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, personas, prestamos, articulos where documentos.Uid = articulos.Uid and articulos.Uid=prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.FechaFin <='", fecfin,"'");
				end if;
			else
				set @valini = ValidarFecha(fecini);
				if @valini = 0 then
					set @salida = 'La fecha de inicio no es válida';
				else
					set @valfin =ValidarFecha(fecfin);
					if @valfin = 0 then
						set @salida = 'La fecha de fin no es válida';
					else
						set @cantidad = (select count(*) from documentos, kumenya_matriculacion.personas, prestamos, articulos where documentos.Uid = articulos.Uid and articulos.Uid = prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.FechaInicio >= fecini and prestamos.FechaFin <= fecfin);
						set @sele = concat("select documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos, articulos where documentos.Uid = articulos.Uid and articulos.Uid=prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.FechaInicio >='", fecini,"' and  prestamos.FechaFin <= '",fecfin,"'");
					end if;
				end if;
			end if;
		end if;
	end if;
	select @exito, @salida, @cantidad, @sele;
END$$

DROP PROCEDURE IF EXISTS `BajaDeDocumento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeDocumento`(id bigint(16),OUT exito int(11), OUT salida varchar(100))
BEGIN
	START TRANSACTION;
	
	if (select count(*) from prestamos where UidDocumento = id and Activo = 1) > 0 then
		
		set @exito = 0;
		set @salida = 'El documento está prestado, no puede darse de baja';
	else
		
		if (select count(*) from reservas where UidDocumento = id and Activo = 1) > 0 then
			
			set @exito = 0;
			set @salida = 'El documento está reservado, no puede darse de baja';
		else
			if (select count(*) from documentos where Uid = id) > 0 then
				update documentos
					set Activo=0, FechaModificacion=NOW(), FechaBaja=NOW()
				where Uid=id;
				set @exito = 1;
				set @salida = "Se ha dado de baja el registro";
			else
				set @exito = 0;
				set @salida= concat("El documento no existe");
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `BajaDePrestamo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDePrestamo`(uidpres bigint(16), out exito int(11), out salida varchar(100))
BEGIN
	START TRANSACTION;
	update documentos set Estado = 1 where Uid= (select UidDocumento from prestamos where Uid=uidpres);
	update documentos set Estado = 3 where Uid in (select UidDocumento from reservas where UidDocumento = (select UidDocumento from prestamos where Uid=uidpres));
	delete from prestamos where Uid = uidpres;
	set @salida = 'Se ha dado de baja el registro';
	set @exito = 1;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `BajaDeReserva`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeReserva`(uidres bigint(16), out exito int(11), out salida varchar(200))
BEGIN
	START TRANSACTION;
	set @doc = (select UidDocumento from reservas where Uid = uidres);
	delete from reservas where Uid = uidres;
	set @hayreser = (select count(*) from reservas where UidDocumento = @doc);
	set @hayprest = (select count(*) from prestamos where UidDocumento = @doc and Activo = 1);
	if (@hayreser > 0) and (@hayprest = 0) then
		update documentos
			set Estado = 3
		where Uid = @doc;
	else
		if (@hayreser = 0) and (@hayprest > 0) then
			update documentos
				set Estado = 2
			where Uid = @doc;
		else
			if (@hayreser > 0) and (@hayprest > 0) then
				update documentos
					set Estado = 2
				where Uid = @doc;
			else
				if (@hayreser = 0) and (@hayprest = 0) then
					update documentos
						set Estado = 1
					where Uid = @doc;
				end if;
			end if;
		end if;
	end if;
	set @salida = 'Se ha dado de baja el registro';
	set @exito = 1;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `BajaDeUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeUsuario`(Id bigint, out exito int(11), out salida varchar(100))
BEGIN
	START TRANSACTION;
	set @usu = (select count(*) from usuarios where Uid = Id);
	if (@usu > 0) then
		update usuarios
			set Activo = 0,
			FechaModificacion = now(),
			FechaBaja = now()
		where Uid = Id;
		set @exito = 1;
		set @salida = 'Se ha dado de baja el registro';
	else
		set @exito = 0;
		set @salida = 'El usuario no existe';
	end if;
	if @exito = 0 then
		ROLLBACK;
	else
		COMMIT;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `CambiarContrasenia`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CambiarContrasenia`(UidUsuario bigint(16), psw_old varchar(45), psw_new varchar(45), OUT exito int(11), OUT salida varchar(100))
BEGIN
	START TRANSACTION;
	set @exito = 0;
	if (select count(1) from usuarios where Uid = UidUsuario and Contrasena = psw_old) > 0 then
		if not isnull(psw_new) then
			update usuarios
			set 	Contrasena = psw_new
			where Uid = UidUsuario;
			set @exito = 1;
			set @salida = 'Se ha modificado la contraseña';
		else
			set @salida = 'La nueva contraseña no se puede dejar vacía';
		end if;
	else
		set @salida = 'La antigua contraseña es incorrecta';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `ConsultaArticulosDisponibles`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaArticulosDisponibles`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), OUT exito int(11), OUT seleccion varchar(1000), OUT tabla varchar(50))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Estado = 1';
	set @tabla = 'documentos';
       	set @exito = 1;
	if (select count(*) from documentos inner join articulos on documentos.Uid = articulos.Uid where documentos.Activo = 1 and documentos.Estado = 1) <> 0 then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if autor is not null then
			set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @seleccion = concat('select documentos.Uid, Titulo, Signatura, Estado, Idioma, PalabrasClave, Autor, NombreFuente, Fasciculo, CodigoFuente from documentos inner join articulos on documentos.Uid = articulos.Uid where ', @criterio);
	else
		set @seleccion = 'select * from documentos inner join articulos on documentos.Uid = articulos.Uid where false';
	end if;
        select @exito, @seleccion, @tabla;
END$$

DROP PROCEDURE IF EXISTS `ConsultaArticulosPrestados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaArticulosPrestados`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), OUT exito int(11), OUT seleccion varchar(1000), OUT tabla varchar(50))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Estado = 2';
	set @tabla = 'documentos';
       	set @exito = 1;
	if (select count(*) from documentos inner join articulos on documentos.Uid = articulos.Uid where documentos.Activo = 1 and documentos.Estado = 2) <> 0 then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if autor is not null then
			set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @seleccion = concat('select documentos.Uid, Titulo, Signatura, Estado, Idioma, PalabrasClave, Autor, NombreFuente, Fasciculo, CodigoFuente from documentos inner join articulos on documentos.Uid = articulos.Uid where ', @criterio);
	else
		set @seleccion = 'select * from documentos inner join articulos on documentos.Uid = articulos.Uid where false';
	end if;
        select @exito, @seleccion, @tabla;
END$$

DROP PROCEDURE IF EXISTS `ConsultaArticulosReservados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaArticulosReservados`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), OUT exito int(11), OUT seleccion varchar(1000), OUT tabla varchar(50))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)';
	set @tabla = 'documentos';
       	set @exito = 1;
	if (select count(*) from documentos inner join articulos on documentos.Uid = articulos.Uid where documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)) <> 0 then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if autor is not null then
			set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @seleccion = concat('select documentos.Uid, Titulo, Signatura, Estado, Idioma, PalabrasClave, Autor, NombreFuente, Fasciculo, CodigoFuente from documentos inner join articulos on documentos.Uid = articulos.Uid where ',@criterio);
	else
		set @seleccion = 'select * from documentos inner join articulos on documentos.Uid = articulos.Uid where false';
	end if;
        select @exito, @seleccion, @tabla;
END$$

DROP PROCEDURE IF EXISTS `ConsultaArticulosSoloReservados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaArticulosSoloReservados`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), OUT exito int(11), OUT seleccion varchar(1000), OUT tabla varchar(50))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1) and documentos.Estado <> 2';
	set @tabla = 'documentos';
       	set @exito = 1;
	if (select count(*) from documentos inner join articulos on documentos.Uid = articulos.Uid where documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)) <> 0 then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if autor is not null then
			set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @seleccion = concat('select documentos.Uid, Titulo, Signatura, Estado, Idioma, PalabrasClave, Autor, NombreFuente, Fasciculo, CodigoFuente from documentos inner join articulos on documentos.Uid = articulos.Uid where ',@criterio);
	else
		set @seleccion = 'select * from documentos inner join articulos on documentos.Uid = articulos.Uid where false';
	end if;
        select @exito, @seleccion, @tabla;
END$$

DROP PROCEDURE IF EXISTS `ConsultaDeArticulo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeArticulo`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), OUT exito int(11), OUT salida varchar(1000), OUT tabla varchar(50))
BEGIN
	set @criterio = "Activo = 1";
	if titulo is not null then
		set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
	end if;
	if autor is not null then
		set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
	end if;
	if clavesi is not null then
		set @cadena = clavesi;
		set @criterio = concat(@criterio, " and (PalabrasClave like ");
		set @pos = instr(@cadena,',');
		if @pos = 0 then
			set @criterio = concat(@criterio, "'%", @cadena, "%'");
			set @cadena = null;
		else
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, "'%", @crit, "%'");
		end if;
		while instr(@cadena, ', ') <> 0 do
			set @pos = instr(@cadena,' ');
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
		end while;
		if @cadena is not null then
			set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
		else
			set @criterio = concat(@criterio, ")");
		end if;
	end if;
	if claveno is not null then
		set @cadena = claveno;
		set @criterio = concat(@criterio, " and (PalabrasClave not like ");
		set @pos = instr(@cadena,',');
		if @pos = 0 then
			set @criterio = concat(@criterio, "'%", @cadena, "%'");
			set @cadena = null;
		else
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, "'%", @crit, "%'");
		end if;
		while instr(@cadena, ', ') <> 0 do
			set @pos = instr(@cadena,' ');
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
		end while;
		if @cadena is not null then
			set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
		else
			set @criterio = concat(@criterio, ")");
		end if;
	end if;
        set @exito = 1;
	set @salida = concat('select documentos.Uid, Titulo, Signatura, Estado, Idioma, PalabrasClave, Autor, NombreFuente, Fasciculo, CodigoFuente from documentos inner join articulos on documentos.Uid = articulos.Uid where ', @criterio);
        set @tabla = 'documentos';
        select @exito, @salida, @tabla;
END$$

DROP PROCEDURE IF EXISTS `ConsultaDeLibro`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeLibro`(titulo varchar(500), autor varchar(100), clavesi varchar(200), claveno varchar(200), OUT exito int(11), OUT salida varchar(1000), OUT tabla varchar(50))
BEGIN
	set @criterio = "Activo = 1";
	if titulo is not null then
		set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
	end if;
	if autor is not null then
		set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
	end if;
	if clavesi is not null then
		set @cadena = clavesi;
		set @criterio = concat(@criterio, " and (PalabrasClave like ");
		set @pos = instr(@cadena,',');
		if @pos = 0 then
			set @criterio = concat(@criterio, "'%", @cadena, "%'");
			set @cadena = null;
		else
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, "'%", @crit, "%'");
		end if;
		while instr(@cadena, ', ') <> 0 do
			set @pos = instr(@cadena,' ');
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
		end while;
		if @cadena is not null then
			set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
		else
			set @criterio = concat(@criterio, ")");
		end if;
	end if;
	if claveno is not null then
		set @cadena = claveno;
		set @criterio = concat(@criterio, " and (PalabrasClave not like ");
		set @pos = instr(@cadena,',');
		if @pos = 0 then
			set @criterio = concat(@criterio, "'%", @cadena, "%'");
			set @cadena = null;
		else
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, "'%", @crit, "%'");
		end if;
		while instr(@cadena, ', ') <> 0 do
			set @pos = instr(@cadena,' ');
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
		end while;
		if @cadena is not null then
			set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
		else
			set @criterio = concat(@criterio, ")");
		end if;
	end if;
        set @exito = 1;
	set @salida = concat('select documentos.Uid, Titulo, Signatura, Estado, Idioma, PalabrasClave, Autor from documentos inner join libros on documentos.Uid = libros.Uid where ', @criterio);
        set @tabla = 'documentos';
        select @exito, @salida, @tabla;
END$$

DROP PROCEDURE IF EXISTS `ConsultaDePrestamos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDePrestamos`(titulo varchar(100), fecini varchar(15), fecfin varchar(15), nomb varchar(50), apell varchar(50), codigo varchar(10), numid varchar(20), OUT exito int(11), OUT salida varchar(900), OUT tabla varchar(50))
BEGIN
	set @exito=1;
	set @tabla = 'documentos';
	set @salida = concat('select prestamos.Uid, documentos.Titulo, documentos.Signatura, documentos.Estado, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona,kumenya_matriculacion.personas.TipoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion	from prestamos, documentos, kumenya_matriculacion.personas where prestamos.UidDocumento in (select Uid from documentos where Titulo like ', concat_ws('%', "'",titulo,"'" ),
				') and prestamos.UidPersona in (select Uid from kumenya_matriculacion.personas where Nombre like ', concat_ws('%', "'",nomb,"'" ),
				' and Apellidos like ', concat_ws('%', "'",apell,"'" ), ' and CodigoPersona like ', concat_ws('%', "'",codigo,"'" ),
				' and NumIdentificacion like ', concat_ws('%', "'",numid,"'" ),
				') ', concat_ws('  ',concat('and prestamos.FechaInicio >=', "'",fecini,"'" ), concat('and prestamos.FechaFin <=', "'",fecfin,"'" )),
				' and prestamos.Activo = 1 and prestamos.UidPersona = personas.Uid and documentos.Uid = prestamos.UidDocumento');
	select @exito, @salida, @tabla;
END$$

DROP PROCEDURE IF EXISTS `ConsultaDeReservas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeReservas`(titulo varchar(100), fecini varchar(15), nomb varchar(50), apell varchar(50), codigo varchar(10), numid varchar(20), OUT exito int(11), OUT salida varchar(900), OUT tabla varchar(50))
BEGIN
	set @exito=1;
	set @tabla = 'documentos';
	set @salida = concat('select reservas.Uid, documentos.Titulo, documentos.Signatura, documentos.Estado, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, kumenya_matriculacion.personas.TipoPersona, reservas.FechaInicio from reservas, documentos, kumenya_matriculacion.personas where reservas.UidDocumento in (select Uid from documentos where Titulo like ', concat_ws('%', "'",titulo,"'" ),
				') and reservas.UidPersona in (select Uid from kumenya_matriculacion.personas where Nombre like ', concat_ws('%', "'",nomb,"'" ),
				' and Apellidos like ', concat_ws('%', "'",apell,"'" ), ' and CodigoPersona like ', concat_ws('%', "'",codigo,"'" ),
				' and NumIdentificacion like ', concat_ws('%', "'",numid,"'" ),
				') ', concat_ws('  ',concat('and reservas.FechaInicio >=', "'",fecini,"'" )),
				' and reservas.Activo = 1 and reservas.UidPersona = personas.Uid and documentos.Uid = reservas.UidDocumento');
	select @exito, @salida, @tabla;
END$$

DROP PROCEDURE IF EXISTS `ConsultaDeRevista`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeRevista`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), OUT exito int(11), OUT salida varchar(1000), OUT tabla varchar(50))
BEGIN
	set @criterio = "Activo=1";
	if (autor is null)  then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @salida = concat('select documentos.Uid, Titulo, Signatura, Estado, Idioma, PalabrasClave, Editor, Numero, Fasciculo, AnioPub, EsRevista from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where ', @criterio);
	else
		set @salida = 'select * from documentos inner join revistasperiodicos on documentos.Uid=revistasperiodicos.Uid where false';
	end if;
        	set @exito = 1;
        	set @tabla = 'documentos';
	        select @exito, @salida, @tabla;
END$$

DROP PROCEDURE IF EXISTS `ConsultaDeUsuarios`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeUsuarios`(out exito int(11), out seleccion varchar(800))
BEGIN
	set @exito = 1;
	set @salida = 'select kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, usuarios.Uid, Usuario, TipoUsuario from kumenya_matriculacion.personas, usuarios where kumenya_matriculacion.personas.Uid = usuarios.Persona and usuarios.Activo = 1';
        select @exito, @salida;
END$$

DROP PROCEDURE IF EXISTS `ConsultaLibrosDisponibles`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaLibrosDisponibles`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), OUT exito int(11), OUT seleccion varchar(1000), OUT tabla varchar(50))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Estado = 1';
        set @tabla = 'documentos';
       	set @exito = 1;
	if (select count(*) from documentos inner join libros on documentos.Uid = libros.Uid where documentos.Activo = 1 and documentos.Estado = 1) <> 0 then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if autor is not null then
			set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @seleccion = concat('select documentos.Uid, Titulo, Signatura, Estado, Idioma, PalabrasClave, Autor from documentos inner join libros on documentos.Uid = libros.Uid where ',@criterio);
	else
		set @seleccion = 'select * from documentos inner join libros on documentos.Uid = libros.Uid where false';
	end if;
        select @exito, @seleccion, @tabla;
END$$

DROP PROCEDURE IF EXISTS `ConsultaLibrosPrestados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaLibrosPrestados`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), OUT exito int(11), OUT seleccion varchar(1000), OUT tabla varchar(50))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Estado = 2';
        set @tabla = 'documentos';
       	set @exito = 1;
	if (select count(*) from documentos inner join libros on documentos.Uid = libros.Uid where documentos.Activo = 1 and documentos.Estado = 2) <> 0 then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if autor is not null then
			set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @seleccion = concat('select documentos.Uid, Titulo, Signatura, Estado, Idioma, PalabrasClave, Autor from documentos inner join libros on documentos.Uid = libros.Uid where ', @criterio);
	else
		set @seleccion = 'select * from documentos inner join libros on documentos.Uid = libros.Uid where false';
	end if;
        select @exito, @seleccion, @tabla;
END$$

DROP PROCEDURE IF EXISTS `ConsultaLibrosReservados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaLibrosReservados`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), OUT exito int(11), OUT seleccion varchar(1000), OUT tabla varchar(50))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)';
        set @tabla = 'documentos';
       	set @exito = 1;
	if (select count(*) from documentos inner join libros on documentos.Uid = libros.Uid where documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)) <> 0 then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if autor is not null then
			set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @seleccion = concat('select documentos.Uid, Titulo, Signatura, Estado, Idioma, PalabrasClave, Autor from documentos inner join libros on documentos.Uid = libros.Uid where ', @criterio);
	else
		set @seleccion = 'select * from documentos inner join libros on documentos.Uid = libros.Uid where false';
	end if;
        select @exito, @seleccion, @tabla;
END$$

DROP PROCEDURE IF EXISTS `ConsultaLibrosSoloReservados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaLibrosSoloReservados`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), OUT exito int(11), OUT seleccion varchar(1000), OUT tabla varchar(50))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1) and documentos.Estado <> 2';
        set @tabla = 'documentos';
       	set @exito = 1;
	if (select count(*) from documentos inner join libros on documentos.Uid = libros.Uid where documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)) <> 0 then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if autor is not null then
			set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @seleccion = concat('select documentos.Uid, Titulo, Signatura, Estado, Idioma, PalabrasClave, Autor from documentos inner join libros on documentos.Uid = libros.Uid where ', @criterio);
	else
		set @seleccion = 'select * from documentos inner join libros on documentos.Uid = libros.Uid where false';
	end if;
        select @exito, @seleccion, @tabla;
END$$

DROP PROCEDURE IF EXISTS `ConsultaParametrosRoot`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaParametrosRoot`(OUT exito int(11), OUT seleccion varchar(400))
BEGIN
	START TRANSACTION;
	set @exito = 1;
	set @salida = 'select Uid, NombreAtributo, Valor from configuracion where Modificable = ''Si'' ';
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `ConsultaRevistasDisponibles`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaRevistasDisponibles`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), OUT exito int(11), OUT seleccion varchar(1000), OUT tabla varchar(50))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Estado = 1';
	set @tabla = 'documentos';
       	set @exito = 1;
	if (select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where documentos.Activo = 1 and documentos.Estado = 1) <> 0 then
		if (autor is null)  then
			if titulo is not null then
				set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
			end if;
			if clavesi is not null then
				set @cadena = clavesi;
				set @criterio = concat(@criterio, " and (PalabrasClave like ");
				set @pos = instr(@cadena,',');
				if @pos = 0 then
					set @criterio = concat(@criterio, "'%", @cadena, "%'");
					set @cadena = null;
				else
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, "'%", @crit, "%'");
				end if;
				while instr(@cadena, ', ') <> 0 do
					set @pos = instr(@cadena,' ');
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
				end while;
				if @cadena is not null then
					set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
				else
					set @criterio = concat(@criterio, ")");
				end if;
			end if;
			if claveno is not null then
				set @cadena = claveno;
				set @criterio = concat(@criterio, " and (PalabrasClave not like ");
				set @pos = instr(@cadena,',');
				if @pos = 0 then
					set @criterio = concat(@criterio, "'%", @cadena, "%'");
					set @cadena = null;
				else
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, "'%", @crit, "%'");
				end if;
				while instr(@cadena, ', ') <> 0 do
					set @pos = instr(@cadena,' ');
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
				end while;
				if @cadena is not null then
					set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
				else
					set @criterio = concat(@criterio, ")");
				end if;
			end if;
			set @seleccion = concat('select documentos.Uid, Titulo, Signatura, Estado, Idioma, PalabrasClave, Editor, Numero, Fasciculo, AnioPub, EsRevista from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where ', @criterio);
		else
			set @seleccion = 'select * from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where false';
		end if;
	else
		set @seleccion = 'select * from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where false';
	end if;
        select @exito, @seleccion, @tabla;
END$$

DROP PROCEDURE IF EXISTS `ConsultaRevistasPrestadas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaRevistasPrestadas`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), OUT exito int(11), OUT seleccion varchar(1000), OUT tabla varchar(50))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Estado = 2';
	set @tabla = 'documentos';
       	set @exito = 1;
	if (select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where documentos.Activo = 1 and documentos.Estado = 2) <> 0 then
		if (autor is null)  then
			if titulo is not null then
				set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
			end if;
			if clavesi is not null then
				set @cadena = clavesi;
				set @criterio = concat(@criterio, " and (PalabrasClave like ");
				set @pos = instr(@cadena,',');
				if @pos = 0 then
					set @criterio = concat(@criterio, "'%", @cadena, "%'");
					set @cadena = null;
				else
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, "'%", @crit, "%'");
				end if;
				while instr(@cadena, ', ') <> 0 do
					set @pos = instr(@cadena,' ');
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
				end while;
				if @cadena is not null then
					set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
				else
					set @criterio = concat(@criterio, ")");
				end if;
			end if;
			if claveno is not null then
				set @cadena = claveno;
				set @criterio = concat(@criterio, " and (PalabrasClave not like ");
				set @pos = instr(@cadena,',');
				if @pos = 0 then
					set @criterio = concat(@criterio, "'%", @cadena, "%'");
					set @cadena = null;
				else
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, "'%", @crit, "%'");
				end if;
				while instr(@cadena, ', ') <> 0 do
					set @pos = instr(@cadena,' ');
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
				end while;
				if @cadena is not null then
					set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
				else
					set @criterio = concat(@criterio, ")");
				end if;
			end if;
			set @seleccion = concat('select documentos.Uid, Titulo, Signatura, Estado, Idioma, PalabrasClave, Editor, Numero, Fasciculo, AnioPub, EsRevista from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where ', @criterio);
		else
			set @seleccion = 'select * from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where false';
		end if;
	else
		set @seleccion = 'select * from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where false';
	end if;
        select @exito, @seleccion, @tabla;
END$$

DROP PROCEDURE IF EXISTS `ConsultaRevistasReservadas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaRevistasReservadas`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), OUT exito int(11), OUT seleccion varchar(1000), OUT tabla varchar(50))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)';
	set @tabla = 'documentos';
       	set @exito = 1;
	if (select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)) <> 0 then
		if (autor is null)  then
			if titulo is not null then
				set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
			end if;
			if clavesi is not null then
				set @cadena = clavesi;
				set @criterio = concat(@criterio, " and (PalabrasClave like ");
				set @pos = instr(@cadena,',');
				if @pos = 0 then
					set @criterio = concat(@criterio, "'%", @cadena, "%'");
					set @cadena = null;
				else
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, "'%", @crit, "%'");
				end if;
				while instr(@cadena, ', ') <> 0 do
					set @pos = instr(@cadena,' ');
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
				end while;
				if @cadena is not null then
					set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
				else
					set @criterio = concat(@criterio, ")");
				end if;
			end if;
			if claveno is not null then
				set @cadena = claveno;
				set @criterio = concat(@criterio, " and (PalabrasClave not like ");
				set @pos = instr(@cadena,',');
				if @pos = 0 then
					set @criterio = concat(@criterio, "'%", @cadena, "%'");
					set @cadena = null;
				else
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, "'%", @crit, "%'");
				end if;
				while instr(@cadena, ', ') <> 0 do
					set @pos = instr(@cadena,' ');
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
				end while;
				if @cadena is not null then
					set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
				else
					set @criterio = concat(@criterio, ")");
				end if;
			end if;
			set @seleccion = concat('select documentos.Uid, Titulo, Signatura, Estado, Idioma, PalabrasClave, Editor, Numero, Fasciculo, AnioPub, EsRevista from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where ', @criterio);
		else
			set @seleccion = 'select * from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where false';
		end if;
	else
		set @seleccion = 'select * from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where false';
	end if;
        select @exito, @seleccion, @tabla;
END$$

DROP PROCEDURE IF EXISTS `ConsultaRevistasSoloReservadas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaRevistasSoloReservadas`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), OUT exito int(11), OUT seleccion varchar(1000), OUT tabla varchar(50))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1) and documentos.Estado <> 2';
	set @tabla = 'documentos';
       	set @exito = 1;
	if (select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)) <> 0 then
		if (autor is null)  then
			if titulo is not null then
				set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
			end if;
			if clavesi is not null then
				set @cadena = clavesi;
				set @criterio = concat(@criterio, " and (PalabrasClave like ");
				set @pos = instr(@cadena,',');
				if @pos = 0 then
					set @criterio = concat(@criterio, "'%", @cadena, "%'");
					set @cadena = null;
				else
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, "'%", @crit, "%'");
				end if;
				while instr(@cadena, ', ') <> 0 do
					set @pos = instr(@cadena,' ');
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
				end while;
				if @cadena is not null then
					set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
				else
					set @criterio = concat(@criterio, ")");
				end if;
			end if;
			if claveno is not null then
				set @cadena = claveno;
				set @criterio = concat(@criterio, " and (PalabrasClave not like ");
				set @pos = instr(@cadena,',');
				if @pos = 0 then
					set @criterio = concat(@criterio, "'%", @cadena, "%'");
					set @cadena = null;
				else
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, "'%", @crit, "%'");
				end if;
				while instr(@cadena, ', ') <> 0 do
					set @pos = instr(@cadena,' ');
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
				end while;
				if @cadena is not null then
					set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
				else
					set @criterio = concat(@criterio, ")");
				end if;
			end if;
			set @seleccion = concat('select documentos.Uid, Titulo, Signatura, Estado, Idioma, PalabrasClave, Editor, Numero, Fasciculo, AnioPub, EsRevista from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where ', @criterio);
		else
			set @seleccion = 'select * from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where false';
		end if;
	else
		set @seleccion = 'select * from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where false';
	end if;
        select @exito, @seleccion, @tabla;
END$$

DROP PROCEDURE IF EXISTS `ConsultaSancionesArticulos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaSancionesArticulos`(out exito int(11), out salida varchar(100), out cantidad int(11), out sele varchar(900))
BEGIN
	set @exito = 1;
	set @salida = 'Los préstamos de artículos con sanción son';
	set @cantidad = (select count(*) from prestamos, documentos, articulos where documentos.Uid = articulos.Uid and articulos.Uid=prestamos.UidDocumento and prestamos.HaySancion = 'Si');
	set @sele = 'select documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos, articulos where documentos.Uid = articulos.Uid and articulos.Uid=prestamos.UidDocumento and prestamos.HaySancion = "Si"';
	select @exito, @salida, @cantidad, @sele;
END$$

DROP PROCEDURE IF EXISTS `ConsultaSancionesLibros`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaSancionesLibros`(out exito int(11), out salida varchar(100), out cantidad int(11), out sele varchar(900))
BEGIN
	set @exito = 1;
	set @salida = 'Los préstamos de libros con sanción son';
	set @cantidad = (select count(*) from prestamos, documentos, libros where documentos.Uid = libros.Uid and libros.Uid=prestamos.UidDocumento and prestamos.HaySancion = 'Si');
	set @sele = 'select documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos, libros where documentos.Uid = libros.Uid and libros.Uid=prestamos.UidDocumento and prestamos.HaySancion = "Si"';
	select @exito, @salida, @cantidad, @sele;
END$$

DROP PROCEDURE IF EXISTS `ConsultaSancionesRevistas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaSancionesRevistas`(out exito int(11), out salida varchar(100), out cantidad int(11), out sele varchar(900))
BEGIN
	set @exito = 1;
	set @salida = 'Los préstamos de periódicos y revistas con sanción son';
	set @cantidad = (select count(*) from prestamos, documentos, revistasperiodicos where documentos.Uid = revistasperiodicos.Uid and revistasperiodicos.Uid=prestamos.UidDocumento and prestamos.HaySancion = 'Si');
	set @sele = 'select documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos, revistasperiodicos where documentos.Uid = revistasperiodicos.Uid and revistasperiodicos.Uid=prestamos.UidDocumento and prestamos.HaySancion = "Si"';
	select @exito, @salida, @cantidad, @sele;
END$$

DROP PROCEDURE IF EXISTS `DetalleDeArticulo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleDeArticulo`(Id bigint(16), OUT exito int(11), OUT salida varchar(1000), OUT tabla varchar(100))
BEGIN
	set @salida = concat('select documentos.Uid, Titulo, Signatura, Autor, Estado, Idioma, NombreFuente, Fasciculo, Volumen, Pagina, CodigoFuente, Observaciones, Traductor, PalabrasClave from documentos inner join articulos on documentos.Uid = articulos.Uid where documentos.Uid = ', Id);
	set @exito = 1;
	set @tabla = 'documentos';
	select @exito, @salida, @tabla;
END$$

DROP PROCEDURE IF EXISTS `DetalleDeLibro`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleDeLibro`(Id bigint(16), OUT exito int(11), OUT salida varchar(1000), OUT tabla varchar(100))
BEGIN
	set @salida = concat('select documentos.Uid, Titulo, Signatura, Autor, Estado, Idioma, ISBN, Volumen, Editorial, DireccionPub, Procedencia, Observaciones, Traductor, PalabrasClave from documentos inner join libros on documentos.Uid = libros.Uid where documentos.Uid = ', Id);
	set @exito = 1;
	set @tabla = 'documentos';
	select @exito, @salida, @tabla;
END$$

DROP PROCEDURE IF EXISTS `DetalleDePrestamo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleDePrestamo`(Id bigint(16), OUT exito int(11), OUT salida varchar(800), OUT tabla varchar(100))
begin
	set @exito=1;
	set @salida = concat('select prestamos.Uid, documentos.Uid as Uiddocumentos, documentos.Titulo, documentos.Signatura, documentos.Estado, kumenya_matriculacion.personas.Uid as Uidpersonas, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, kumenya_matriculacion.personas.TipoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion
from documentos, kumenya_matriculacion.personas, prestamos where  documentos.Uid= prestamos.UidDocumento and kumenya_matriculacion.personas.Uid=prestamos.UidPersona and prestamos.Activo  = 1 and prestamos.Uid= ',Id);
	set @tabla = 'documentos';
	select @exito, @salida, @tabla;
end$$

DROP PROCEDURE IF EXISTS `DetalleDeReserva`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleDeReserva`(Id bigint(16), OUT exito int(11), OUT salida varchar(800), OUT tabla varchar(100))
begin
	set @salida = concat('select reservas.Uid, documentos.Uid as Uiddocumentos, documentos.Titulo, documentos.Signatura, documentos.Estado, kumenya_matriculacion.personas.Uid as Uidpersonas, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, kumenya_matriculacion.personas.TipoPersona, reservas.FechaInicio
from documentos, kumenya_matriculacion.personas, reservas where  documentos.Uid= reservas.UidDocumento and kumenya_matriculacion.personas.Uid=reservas.UidPersona and reservas.Activo  = 1 and reservas.Uid= ',Id);
	set @exito = 1;
	set @tabla = 'documentos';
	select @exito, @salida, @tabla;
end$$

DROP PROCEDURE IF EXISTS `DetalleDeRevista`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleDeRevista`(Id bigint(16), OUT exito int(11), OUT salida varchar(1000), OUT tabla varchar(100))
BEGIN
	set @salida = concat('select documentos.Uid, EsRevista, AnioPub, Titulo, Signatura, Numero, Fasciculo, Volumen, Estado, Idioma, Editor, DireccionPub, FechaSuscripcion, Frecuencia, Observaciones, Traductor, PalabrasClave from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where documentos.Uid = ', Id);
	set @exito = 1;
	set @tabla = 'documentos';
	select @exito, @salida, @tabla;
END$$

DROP PROCEDURE IF EXISTS `DetalleDeUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleDeUsuario`(Id bigint(16), out exito int(11), out salida varchar(500))
BEGIN
	set @exito = 1;
	set @salida = concat('select usuarios.Uid, personas.Uid as Uidpersonas, Usuario, TipoUsuario,  kumenya_matriculacion.personas.Nombre as Nombre, kumenya_matriculacion.personas.Apellidos as Apellidos ',
				'from usuarios, kumenya_matriculacion.personas where usuarios.Persona = kumenya_matriculacion.personas.Uid and  usuarios.Uid =''',Id,"'");
	set @tabla = 'usuarios';
	select @exito, @salida;
END$$

DROP PROCEDURE IF EXISTS `DetallePrestamoConSancion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetallePrestamoConSancion`(Id bigint(16), out exito int(11), out seleccion varchar(1000), out tabla varchar(50))
begin
	set @exito=1;
	set @desde = (select kumenya_biblioteca.prestamos.FechaFin from kumenya_biblioteca.prestamos where kumenya_biblioteca.prestamos.Uid = Id);
	set @hasta = (select kumenya_biblioteca.prestamos.FechaDevolucion from kumenya_biblioteca.prestamos where kumenya_biblioteca.prestamos.Uid = Id);
	set @cuanto = ((datediff(@hasta, @desde)) - 1) * (select kumenya_biblioteca.configuracion.Valor from kumenya_biblioteca.configuracion where kumenya_biblioteca.configuracion.NombreAtributo = 'SancionBiblioteca');
	set @seleccion = concat('select prestamos.Uid, documentos.Uid as Uiddocumentos, ', @cuanto, ' as Sancion, documentos.Titulo, documentos.Signatura, documentos.Estado, kumenya_matriculacion.personas.Uid as Uidpersonas, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, kumenya_matriculacion.personas.TipoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion
from documentos, kumenya_matriculacion.personas, prestamos where prestamos.Uid = ', Id, ' and documentos.Uid = prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.Activo  = 1');
	set @tabla = 'documentos';
	select @exito, @seleccion, @tabla;
end$$

DROP PROCEDURE IF EXISTS `DevolucionDeDocumento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DevolucionDeDocumento`(uidin bigint(16), out exito int(11), out salida varchar(200))
BEGIN
	START TRANSACTION;
	if (select count(*) from prestamos where Uid=uidin and Activo = 1) != 0 then
		set @uiddoc = (select UidDocumento from prestamos where Uid=uidin);
		update prestamos
		set	 FechaDevolucion = now()
		where Uid= uidin;
		UPDATE documentos
			set Estado=1
		WHERE Uid= @uiddoc;
		UPDATE documentos
			set Estado=3
		WHERE Uid in (select distinct(UidDocumento) from reservas where Activo=1);
		set @salida= 'Devolución registrada';
		if (select FechaDevolucion from prestamos where Uid=uidin and Activo=1) > (select FechaFin from prestamos where Uid=uidin and Activo=1) then
			update prestamos set HaySancion=1, Activo=1 where Uid=uidin;
			set @salida = concat(@salida, ". Se ha generado una sanción");
		else
			update prestamos set Activo = 0 where Uid = uidin;
		end if;
		set @exito = 1;
	else
		set @salida = "No existe el préstamo";
		set @exito = 0;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
END$$

DROP PROCEDURE IF EXISTS `EstadConsultaPrestamosArticulos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadConsultaPrestamosArticulos`(titulo varchar(100), fecini varchar(15), fecfin varchar(15), nomb varchar(50), apell varchar(50), codigo varchar(10), numid varchar(20), OUT exito int(11), OUT presta varchar(1000))
begin
	set @exito = 1;
	set @presta = concat('select count(1) from prestamos where UidDocumento in (select Uid from articulos where Uid in (select Uid from documentos where Titulo like ', concat_ws('%', "'",titulo,"'" ),
				')) and UidPersona in (select Uid from kumenya_matriculacion.personas where Nombre like ', concat_ws('%', "'",nomb,"'" ),
				' and Apellidos like ', concat_ws('%', "'",apell,"'" ), ' and CodigoPersona like ', concat_ws('%', "'",codigo,"'" ),
				' and NumIdentificacion like ', concat_ws('%', "'",numid,"'" ),
				') ', concat_ws('  ',concat('and FechaInicio >=', "'",fecini,"'" ), concat('and FechaFin <=', "'",fecfin,"'" )),
				' and prestamos.Activo = 1');
	select @exito, @presta;
end$$

DROP PROCEDURE IF EXISTS `EstadConsultaPrestamosLibros`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadConsultaPrestamosLibros`(titulo varchar(100), fecini varchar(15), fecfin varchar(15), nomb varchar(50), apell varchar(50), codigo varchar(10), numid varchar(20), OUT exito int(11), OUT presta varchar(1000))
begin
	set @exito = 1;
	set @presta = concat('select count(1) from prestamos where UidDocumento in (select Uid from libros where Uid in (select Uid from documentos where Titulo like ', concat_ws('%', "'",titulo,"'" ),
				')) and UidPersona in (select Uid from kumenya_matriculacion.personas where Nombre like ', concat_ws('%', "'",nomb,"'" ),
				' and Apellidos like ', concat_ws('%', "'",apell,"'" ), ' and CodigoPersona like ', concat_ws('%', "'",codigo,"'" ),
				' and NumIdentificacion like ', concat_ws('%', "'",numid,"'" ),
				') ', concat_ws('  ',concat('and FechaInicio >=', "'",fecini,"'" ), concat('and FechaFin <=', "'",fecfin,"'" )),
				' and prestamos.Activo = 1');
	select @exito, @presta;
end$$

DROP PROCEDURE IF EXISTS `EstadConsultaPrestamosRevistas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadConsultaPrestamosRevistas`(titulo varchar(100), fecini varchar(15), fecfin varchar(15), nomb varchar(50), apell varchar(50), codigo varchar(10), numid varchar(20), OUT exito int(11), OUT presta varchar(900))
begin
	set @exito = 1;
	set @presta = concat('select count(1) from prestamos where UidDocumento in (select Uid from revistasperiodicos where Uid in (select Uid from documentos where Titulo like ', concat_ws('%', "'",titulo,"'" ),
				')) and UidPersona in (select Uid from kumenya_matriculacion.personas where Nombre like ', concat_ws('%', "'",nomb,"'" ),
				' and Apellidos like ', concat_ws('%', "'",apell,"'" ), ' and CodigoPersona like ', concat_ws('%', "'",codigo,"'" ),
				' and NumIdentificacion like ', concat_ws('%', "'",numid,"'" ),
				') ', concat_ws('  ',concat('and FechaInicio >=', "'",fecini,"'" ), concat('and FechaFin <=', "'",fecfin,"'" )),
				' and prestamos.Activo = 1');
	select @exito, @presta;
end$$

DROP PROCEDURE IF EXISTS `EstadConsultaReservasArticulos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadConsultaReservasArticulos`(titulo varchar(100), fecini varchar(15), nomb varchar(50), apell varchar(50), codigo varchar(10), numid varchar(20), OUT exito int(11), OUT reserv varchar(1000))
begin
	set @exito = 1;
	set @reserv = concat('select count(1) from reservas where UidDocumento in (select Uid from articulos where Uid in (select Uid from documentos where Titulo like ', concat_ws('%', "'",titulo,"'" ),
				')) and UidPersona in (select Uid from kumenya_matriculacion.personas where Nombre like ', concat_ws('%', "'",nomb,"'" ),
				' and Apellidos like ', concat_ws('%', "'",apell,"'" ), ' and CodigoPersona like ', concat_ws('%', "'",codigo,"'" ),
				' and NumIdentificacion like ', concat_ws('%', "'",numid,"'" ),
				') ', concat_ws('  ',concat('and FechaInicio >=', "'",fecini,"'" )));
	select @exito, @reserv;
end$$

DROP PROCEDURE IF EXISTS `EstadConsultaReservasLibros`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadConsultaReservasLibros`(titulo varchar(100), fecini varchar(15), nomb varchar(50), apell varchar(50), codigo varchar(10), numid varchar(20), OUT exito int(11), OUT reserv varchar(1000))
begin
	set @exito = 1;
	set @reserv = concat('select count(1) from reservas where UidDocumento in (select Uid from libros where Uid in (select Uid from documentos where Titulo like ', concat_ws('%', "'",titulo,"'" ),
				')) and UidPersona in (select Uid from kumenya_matriculacion.personas where Nombre like ', concat_ws('%', "'",nomb,"'" ),
				' and Apellidos like ', concat_ws('%', "'",apell,"'" ), ' and CodigoPersona like ', concat_ws('%', "'",codigo,"'" ),
				' and NumIdentificacion like ', concat_ws('%', "'",numid,"'" ),
				') ', concat_ws('  ',concat('and FechaInicio >=', "'",fecini,"'" )));
	select @exito, @reserv;
end$$

DROP PROCEDURE IF EXISTS `EstadConsultaReservasRevistas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadConsultaReservasRevistas`(titulo varchar(100), fecini varchar(15), nomb varchar(50), apell varchar(50), codigo varchar(10), numid varchar(20), OUT exito int(11), OUT reserv varchar(1000))
begin
	set @exito = 1;
	set @reserv = concat('select count(1) from reservas where UidDocumento in (select Uid from revistasperiodicos where Uid in (select Uid from documentos where Titulo like ', concat_ws('%', "'",titulo,"'" ),
				')) and UidPersona in (select Uid from kumenya_matriculacion.personas where Nombre like ', concat_ws('%', "'",nomb,"'" ),
				' and Apellidos like ', concat_ws('%', "'",apell,"'" ), ' and CodigoPersona like ', concat_ws('%', "'",codigo,"'" ),
				' and NumIdentificacion like ', concat_ws('%', "'",numid,"'" ),
				') ', concat_ws('  ',concat('and FechaInicio >=', "'",fecini,"'" )));
	select @exito, @reserv;
end$$

DROP PROCEDURE IF EXISTS `EstadisticasArticulosDisponibles`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadisticasArticulosDisponibles`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), out exito int(11), out disp varchar(1000))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Estado = 1';
       	set @exito = 1;
	if (select count(*) from documentos inner join articulos on documentos.Uid = articulos.Uid where documentos.Activo = 1 and documentos.Estado = 1) <> 0 then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if autor is not null then
			set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @disp = concat('select count(*) from documentos inner join articulos on documentos.Uid = articulos.Uid where ', @criterio);
	else
		set @disp = 'select count(*) from documentos inner join articulos on documentos.Uid = articulos.Uid where false';
	end if;
        select @exito, @disp;
END$$

DROP PROCEDURE IF EXISTS `EstadisticasArticulosPrestados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadisticasArticulosPrestados`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), out exito int(11), out prest varchar(1000))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Estado = 2';
       	set @exito = 1;
	if (select count(*) from documentos inner join articulos on documentos.Uid = articulos.Uid where documentos.Activo = 1 and documentos.Estado = 2) <> 0 then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if autor is not null then
			set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @prest = concat('select count(*) from documentos inner join articulos on documentos.Uid = articulos.Uid where ', @criterio);
	else
		set @prest = 'select count(*) from documentos inner join articulos on documentos.Uid = articulos.Uid where false';
	end if;
        select @exito, @prest;
END$$

DROP PROCEDURE IF EXISTS `EstadisticasArticulosReservados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadisticasArticulosReservados`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), out exito int(11), out reser varchar(1000))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)';
       	set @exito = 1;
	if (select count(*) from documentos inner join articulos on documentos.Uid = articulos.Uid where documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)) <> 0 then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if autor is not null then
			set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @reser = concat('select count(*) from documentos inner join articulos on documentos.Uid = articulos.Uid where ',@criterio);
	else
		set @reser = 'select count(*) from documentos inner join articulos on documentos.Uid = articulos.Uid where false';
	end if;
        select @exito, @reser;
END$$

DROP PROCEDURE IF EXISTS `EstadisticasArticulosSoloReservados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadisticasArticulosSoloReservados`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), out exito int(11), out reser varchar(1000))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1) and documentos.Estado <> 2';
       	set @exito = 1;
	if (select count(*) from documentos inner join articulos on documentos.Uid = articulos.Uid where documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)) <> 0 then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if autor is not null then
			set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @reser = concat('select count(*) from documentos inner join articulos on documentos.Uid = articulos.Uid where ',@criterio);
	else
		set @reser = 'select count(*) from documentos inner join articulos on documentos.Uid = articulos.Uid where false';
	end if;
        select @exito, @reser;
END$$

DROP PROCEDURE IF EXISTS `EstadisticasConsulArticulo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadisticasConsulArticulo`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), out exito int(11), out rob int(11), out dispo int(11), out per int(11), out prest int(11), out rese int(11))
BEGIN
	set @criterio = "Activo = 1";
	if titulo is not null then
		set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
	end if;
	if autor is not null then
		set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
	end if;
	if clavesi is not null then
		set @cadena = clavesi;
		set @criterio = concat(@criterio, " and (PalabrasClave like ");
		set @pos = instr(@cadena,',');
		if @pos = 0 then
			set @criterio = concat(@criterio, "'%", @cadena, "%'");
			set @cadena = null;
		else
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, "'%", @crit, "%'");
		end if;
		while instr(@cadena, ', ') <> 0 do
			set @pos = instr(@cadena,' ');
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
		end while;
		if @cadena is not null then
			set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
		else
			set @criterio = concat(@criterio, ")");
		end if;
	end if;
	if claveno is not null then
		set @cadena = claveno;
		set @criterio = concat(@criterio, " and (PalabrasClave not like ");
		set @pos = instr(@cadena,',');
		if @pos = 0 then
			set @criterio = concat(@criterio, "'%", @cadena, "%'");
			set @cadena = null;
		else
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, "'%", @crit, "%'");
		end if;
		while instr(@cadena, ', ') <> 0 do
			set @pos = instr(@cadena,' ');
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
		end while;
		if @cadena is not null then
			set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
		else
			set @criterio = concat(@criterio, ")");
		end if;
	end if;
        set @exito = 1;
	set @rob = (select count(*) from documentos inner join articulos on documentos.Uid=articulos.Uid where (select concat(@criterio, ' and documentos.Estado=4')));
	set @disp = (select count(*) from documentos inner join articulos on documentos.Uid=articulos.Uid where (select concat(@criterio, ' and documentos.Estado=1')));
	set @per = (select count(*) from documentos inner join articulos on documentos.Uid=articulos.Uid where (select concat(@criterio, ' and documentos.Estado=5')));
	set @prest = (select count(*) from documentos inner join articulos on documentos.Uid=articulos.Uid where (select concat(@criterio, ' and documentos.Estado=2')));
	set @rese = (select count(*) from documentos inner join articulos on documentos.Uid=articulos.Uid where (select concat(@criterio, ' and documentos.Estado=3')));
        select @exito, @rob, @dispo, @per, @prest, @rese;
END$$

DROP PROCEDURE IF EXISTS `EstadisticasConsulLibro`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadisticasConsulLibro`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), out exito int(11), out rob int(11), out dispo int(11), out per int(11), out prest int(11), out rese int(11))
BEGIN
	set @criterio = "Activo = 1";
	if titulo is not null then
		set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
	end if;
	if autor is not null then
		set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
	end if;
	if clavesi is not null then
		set @cadena = clavesi;
		set @criterio = concat(@criterio, " and (PalabrasClave like ");
		set @pos = instr(@cadena,',');
		if @pos = 0 then
			set @criterio = concat(@criterio, "'%", @cadena, "%'");
			set @cadena = null;
		else
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, "'%", @crit, "%'");
		end if;
		while instr(@cadena, ', ') <> 0 do
			set @pos = instr(@cadena,' ');
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
		end while;
		if @cadena is not null then
			set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
		else
			set @criterio = concat(@criterio, ")");
		end if;
	end if;
	if claveno is not null then
		set @cadena = claveno;
		set @criterio = concat(@criterio, " and (PalabrasClave not like ");
		set @pos = instr(@cadena,',');
		if @pos = 0 then
			set @criterio = concat(@criterio, "'%", @cadena, "%'");
			set @cadena = null;
		else
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, "'%", @crit, "%'");
		end if;
		while instr(@cadena, ', ') <> 0 do
			set @pos = instr(@cadena,' ');
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
		end while;
		if @cadena is not null then
			set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
		else
			set @criterio = concat(@criterio, ")");
		end if;
	end if;
        set @exito = 1;
	set @rob = (select count(*) from documentos inner join libros on documentos.Uid=libros.Uid where (select concat(@criterio, ' and documentos.Estado=4')));
	set @disp = (select count(*) from documentos inner join libros on documentos.Uid=libros.Uid where (select concat(@criterio, ' and documentos.Estado=1')));
	set @per = (select count(*) from documentos inner join libros on documentos.Uid=libros.Uid where (select concat(@criterio, ' and documentos.Estado=5')));
	set @prest = (select count(*) from documentos inner join libros on documentos.Uid=libros.Uid where (select concat(@criterio, ' and documentos.Estado=2')));
	set @rese = (select count(*) from documentos inner join libros on documentos.Uid=libros.Uid where (select concat(@criterio, ' and documentos.Estado=3')));
        select @exito, @rob, @dispo, @per, @prest, @rese;
END$$

DROP PROCEDURE IF EXISTS `EstadisticasConsulRevista`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadisticasConsulRevista`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), out exito int(11), out rob int(11), out disp int(11), out per int(11), out prest int(11), out rese int(11))
BEGIN
	set @rob = 0;
	set @disp = 0;
	set @per = 0;
	set @prest = 0;
	set @rese = 0;
	set @criterio = "Activo=1";
	if (autor is null)  then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @rob = (select count(*) from documentos inner join revistasperiodicos on documentos.Uid=revistasperiodicos.Uid where (select concat(@criterio, ' and documentos.Estado=4')));
		set @disp = (select count(*) from documentos inner join revistasperiodicos on documentos.Uid=revistasperiodicos.Uid where (select concat(@criterio, ' and documentos.Estado=1')));
		set @per = (select count(*) from documentos inner join revistasperiodicos on documentos.Uid=revistasperiodicos.Uid where (select concat(@criterio, ' and documentos.Estado=5')));
		set @prest = (select count(*) from documentos inner join revistasperiodicos on documentos.Uid=revistasperiodicos.Uid where (select concat(@criterio, ' and documentos.Estado=2')));
		set @rese = (select count(*) from documentos inner join revistasperiodicos on documentos.Uid=revistasperiodicos.Uid where (select concat(@criterio, ' and documentos.Estado=3')));
	        set @exito = 1;
	else
		set @exito= 0;
	end if;
	        select @exito, @rob, @disp, @per, @prest, @rese;
END$$

DROP PROCEDURE IF EXISTS `EstadisticasConsultaArticulo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadisticasConsultaArticulo`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), out exito int(11), out rob varchar(1000), out disp varchar(1000), out per varchar(1000), out prest varchar(1000), out rese varchar(1000))
BEGIN
	set @criterio = "Activo = 1";
	if titulo is not null then
		set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
	end if;
	if autor is not null then
		set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
	end if;
	if clavesi is not null then
		set @cadena = clavesi;
		set @criterio = concat(@criterio, " and (PalabrasClave like ");
		set @pos = instr(@cadena,',');
		if @pos = 0 then
			set @criterio = concat(@criterio, "'%", @cadena, "%'");
			set @cadena = null;
		else
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, "'%", @crit, "%'");
		end if;
		while instr(@cadena, ', ') <> 0 do
			set @pos = instr(@cadena,' ');
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
		end while;
		if @cadena is not null then
			set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
		else
			set @criterio = concat(@criterio, ")");
		end if;
	end if;
	if claveno is not null then
		set @cadena = claveno;
		set @criterio = concat(@criterio, " and (PalabrasClave not like ");
		set @pos = instr(@cadena,',');
		if @pos = 0 then
			set @criterio = concat(@criterio, "'%", @cadena, "%'");
			set @cadena = null;
		else
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, "'%", @crit, "%'");
		end if;
		while instr(@cadena, ', ') <> 0 do
			set @pos = instr(@cadena,' ');
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
		end while;
		if @cadena is not null then
			set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
		else
			set @criterio = concat(@criterio, ")");
		end if;
	end if;
        set @exito = 1;
	set @rob = concat('select count(*) from documentos inner join articulos on documentos.Uid=articulos.Uid where ', concat(@criterio, ' and documentos.Estado=4'));
	set @disp = concat('select count(*) from documentos inner join articulos on documentos.Uid=articulos.Uid where ', concat(@criterio, ' and documentos.Estado=1'));
	set @per = concat('select count(*) from documentos inner join articulos on documentos.Uid=articulos.Uid where ', concat(@criterio, ' and documentos.Estado=5'));
	set @prest = concat('select count(*) from documentos inner join articulos on documentos.Uid=articulos.Uid where ', concat(@criterio, ' and documentos.Estado=2'));
	set @rese = concat('select count(*) from documentos inner join articulos on documentos.Uid=articulos.Uid where ', concat(@criterio, ' and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)'));
        select @exito, @rob, @disp, @per, @prest, @rese;
END$$

DROP PROCEDURE IF EXISTS `EstadisticasConsultaLibro`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadisticasConsultaLibro`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), out exito int(11), out rob varchar(1000), out disp varchar(1000), out per varchar(1000), out prest varchar(1000), out rese varchar(1000))
BEGIN
	set @criterio = "Activo = 1";
	if titulo is not null then
		set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
	end if;
	if autor is not null then
		set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
	end if;
	if clavesi is not null then
		set @cadena = clavesi;
		set @criterio = concat(@criterio, " and (PalabrasClave like ");
		set @pos = instr(@cadena,',');
		if @pos = 0 then
			set @criterio = concat(@criterio, "'%", @cadena, "%'");
			set @cadena = null;
		else
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, "'%", @crit, "%'");
		end if;
		while instr(@cadena, ', ') <> 0 do
			set @pos = instr(@cadena,' ');
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
		end while;
		if @cadena is not null then
			set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
		else
			set @criterio = concat(@criterio, ")");
		end if;
	end if;
	if claveno is not null then
		set @cadena = claveno;
		set @criterio = concat(@criterio, " and (PalabrasClave not like ");
		set @pos = instr(@cadena,',');
		if @pos = 0 then
			set @criterio = concat(@criterio, "'%", @cadena, "%'");
			set @cadena = null;
		else
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, "'%", @crit, "%'");
		end if;
		while instr(@cadena, ', ') <> 0 do
			set @pos = instr(@cadena,' ');
			set @crit = left(@cadena, @pos-1);
			set @cadena = substring(@cadena,@pos+1);
			set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
		end while;
		if @cadena is not null then
			set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
		else
			set @criterio = concat(@criterio, ")");
		end if;
	end if;
        set @exito = 1;
	set @rob = concat('select count(*) from documentos inner join libros on documentos.Uid=libros.Uid where ', concat(@criterio, ' and documentos.Estado=4'));
	set @disp = concat('select count(*) from documentos inner join libros on documentos.Uid=libros.Uid where ', concat(@criterio, ' and documentos.Estado=1'));
	set @per = concat('select count(*) from documentos inner join libros on documentos.Uid=libros.Uid where ', concat(@criterio, ' and documentos.Estado=5'));
	set @prest = concat('select count(*) from documentos inner join libros on documentos.Uid=libros.Uid where ',concat(@criterio, ' and documentos.Estado=2'));
	set @rese = concat('select count(*) from documentos inner join libros on documentos.Uid=libros.Uid where ', concat(@criterio, ' and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)'));
        select @exito, @rob, @disp, @per, @prest, @rese;
END$$

DROP PROCEDURE IF EXISTS `EstadisticasConsultaRevista`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadisticasConsultaRevista`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), out exito int(11), out rob varchar(1000), out disp varchar(1000), out per varchar(1000), out prest varchar(1000), out rese varchar(1000))
BEGIN
        set @exito = 1;
	set @criterio = "Activo=1";
	if (autor is null)  then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @rob = concat('select count(*) from documentos inner join revistasperiodicos on documentos.Uid=revistasperiodicos.Uid where ', concat(@criterio, ' and documentos.Estado=4'));
		set @disp = concat('select count(*) from documentos inner join revistasperiodicos on documentos.Uid=revistasperiodicos.Uid where ', concat(@criterio, ' and documentos.Estado=1'));
		set @per = concat('select count(*) from documentos inner join revistasperiodicos on documentos.Uid=revistasperiodicos.Uid where ', concat(@criterio, ' and documentos.Estado=5'));
		set @prest = concat('select count(*) from documentos inner join revistasperiodicos on documentos.Uid=revistasperiodicos.Uid where ', concat(@criterio, ' and documentos.Estado=2'));
		set @rese = concat('select count(*) from documentos inner join revistasperiodicos on documentos.Uid=revistasperiodicos.Uid where ', concat(@criterio, ' and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)'));
	else
		set @rob = 'select count(*) from documentos inner join revistasperiodicos on documentos.Uid=revistasperiodicos.Uid where false';
		set @disp = 'select count(*) from documentos inner join revistasperiodicos on documentos.Uid=revistasperiodicos.Uid where false';
		set @per = 'select count(*) from documentos inner join revistasperiodicos on documentos.Uid=revistasperiodicos.Uid where false';
		set @prest = 'select count(*) from documentos inner join revistasperiodicos on documentos.Uid=revistasperiodicos.Uid where false';
		set @rese = 'select count(*) from documentos inner join revistasperiodicos on documentos.Uid=revistasperiodicos.Uid where false';
	end if;
	        select @exito, @rob, @disp, @per, @prest, @rese;
END$$

DROP PROCEDURE IF EXISTS `EstadisticasLibrosDisponibles`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadisticasLibrosDisponibles`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), out exito int(11), out disp varchar(1000))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Estado = 1';
       	set @exito = 1;
	if (select count(*) from documentos inner join libros on documentos.Uid = libros.Uid where documentos.Activo = 1 and documentos.Estado = 1) <> 0 then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if autor is not null then
			set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @disp = concat('select count(*) from documentos inner join libros on documentos.Uid=libros.Uid where ', @criterio);
	else
		set @disp = 'select count(*) from documentos inner join libros on documentos.Uid = libros.Uid where false';
	end if;
        select @exito, @disp;
END$$

DROP PROCEDURE IF EXISTS `EstadisticasLibrosPrestados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadisticasLibrosPrestados`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), out exito int(11), out prest varchar(1000))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Estado = 2';
       	set @exito = 1;
	if (select count(*) from documentos inner join libros on documentos.Uid = libros.Uid where documentos.Activo = 1 and documentos.Estado = 2) <> 0 then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if autor is not null then
			set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @prest = concat('select count(*) from documentos inner join libros on documentos.Uid = libros.Uid where ', @criterio);
	else
		set @prest = 'select count(*) from documentos inner join libros on documentos.Uid = libros.Uid where false';
	end if;
        select @exito, @prest;
END$$

DROP PROCEDURE IF EXISTS `EstadisticasLibrosReservados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadisticasLibrosReservados`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), out exito int(11), out reser varchar(1000))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)';
       	set @exito = 1;
	if (select count(*) from documentos inner join libros on documentos.Uid = libros.Uid where documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)) <> 0 then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if autor is not null then
			set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @reser = concat('select count(*) from documentos inner join libros on documentos.Uid = libros.Uid where ', @criterio);
	else
		set @reser = 'select count(*) from documentos inner join libros on documentos.Uid = libros.Uid where false';
	end if;
        select @exito, @reser;
END$$

DROP PROCEDURE IF EXISTS `EstadisticasLibrosSoloReservados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadisticasLibrosSoloReservados`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), out exito int(11), out reser varchar(1000))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1) and documentos.Estado <> 2';
       	set @exito = 1;
	if (select count(*) from documentos inner join libros on documentos.Uid = libros.Uid where documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)) <> 0 then
		if titulo is not null then
			set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
		end if;
		if autor is not null then
			set @criterio = concat(@criterio, " and Autor like '%", autor,  "%'");
		end if;
		if clavesi is not null then
			set @cadena = clavesi;
			set @criterio = concat(@criterio, " and (PalabrasClave like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		if claveno is not null then
			set @cadena = claveno;
			set @criterio = concat(@criterio, " and (PalabrasClave not like ");
			set @pos = instr(@cadena,',');
			if @pos = 0 then
				set @criterio = concat(@criterio, "'%", @cadena, "%'");
				set @cadena = null;
			else
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, "'%", @crit, "%'");
			end if;
			while instr(@cadena, ', ') <> 0 do
				set @pos = instr(@cadena,' ');
				set @crit = left(@cadena, @pos-1);
				set @cadena = substring(@cadena,@pos+1);
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
			end while;
			if @cadena is not null then
				set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
			else
				set @criterio = concat(@criterio, ")");
			end if;
		end if;
		set @reser = concat('select count(*) from documentos inner join libros on documentos.Uid = libros.Uid where ', @criterio);
	else
		set @reser = 'select count(*) from documentos inner join libros on documentos.Uid = libros.Uid where false';
	end if;
        select @exito, @reser;
END$$

DROP PROCEDURE IF EXISTS `EstadisticasRevistasDisponibles`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadisticasRevistasDisponibles`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), out exito int(11), out disp varchar(1000))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Estado = 1';
       	set @exito = 1;
	if (select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where documentos.Activo = 1 and documentos.Estado = 1) <> 0 then
		if (autor is null)  then
			if titulo is not null then
				set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
			end if;
			if clavesi is not null then
				set @cadena = clavesi;
				set @criterio = concat(@criterio, " and (PalabrasClave like ");
				set @pos = instr(@cadena,',');
				if @pos = 0 then
					set @criterio = concat(@criterio, "'%", @cadena, "%'");
					set @cadena = null;
				else
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, "'%", @crit, "%'");
				end if;
				while instr(@cadena, ', ') <> 0 do
					set @pos = instr(@cadena,' ');
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
				end while;
				if @cadena is not null then
					set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
				else
					set @criterio = concat(@criterio, ")");
				end if;
			end if;
			if claveno is not null then
				set @cadena = claveno;
				set @criterio = concat(@criterio, " and (PalabrasClave not like ");
				set @pos = instr(@cadena,',');
				if @pos = 0 then
					set @criterio = concat(@criterio, "'%", @cadena, "%'");
					set @cadena = null;
				else
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, "'%", @crit, "%'");
				end if;
				while instr(@cadena, ', ') <> 0 do
					set @pos = instr(@cadena,' ');
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
				end while;
				if @cadena is not null then
					set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
				else
					set @criterio = concat(@criterio, ")");
				end if;
			end if;
			set @disp = concat('select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where ', @criterio);
		else
			set @disp = 'select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where false';
		end if;
	else
		set @disp = 'select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where false';
	end if;
        select @exito, @disp;
END$$

DROP PROCEDURE IF EXISTS `EstadisticasRevistasPrestadas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadisticasRevistasPrestadas`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), out exito int(11), prest varchar(1000))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Estado = 2';
	set @exito = 1;
	if (select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where documentos.Activo = 1 and documentos.Estado = 2) <> 0 then
		if (autor is null)  then
			if titulo is not null then
				set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
			end if;
			if clavesi is not null then
				set @cadena = clavesi;
				set @criterio = concat(@criterio, " and (PalabrasClave like ");
				set @pos = instr(@cadena,',');
				if @pos = 0 then
					set @criterio = concat(@criterio, "'%", @cadena, "%'");
					set @cadena = null;
				else
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, "'%", @crit, "%'");
				end if;
				while instr(@cadena, ', ') <> 0 do
					set @pos = instr(@cadena,' ');
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
				end while;
				if @cadena is not null then
					set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
				else
					set @criterio = concat(@criterio, ")");
				end if;
			end if;
			if claveno is not null then
				set @cadena = claveno;
				set @criterio = concat(@criterio, " and (PalabrasClave not like ");
				set @pos = instr(@cadena,',');
				if @pos = 0 then
					set @criterio = concat(@criterio, "'%", @cadena, "%'");
					set @cadena = null;
				else
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, "'%", @crit, "%'");
				end if;
				while instr(@cadena, ', ') <> 0 do
					set @pos = instr(@cadena,' ');
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
				end while;
				if @cadena is not null then
					set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
				else
					set @criterio = concat(@criterio, ")");
				end if;
			end if;
			set @prest = concat('select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where ', @criterio);
		else
			set @prest = 'select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where false';
		end if;
	else
		set @prest = 'select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where false';
	end if;
        select @exito, @prest;
END$$

DROP PROCEDURE IF EXISTS `EstadisticasRevistasReservadas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadisticasRevistasReservadas`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), out exito int(11), out reser varchar(1000))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)';
	set @exito = 1;
	if (select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)) <> 0 then
		if (autor is null)  then
			if titulo is not null then
				set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
			end if;
			if clavesi is not null then
				set @cadena = clavesi;
				set @criterio = concat(@criterio, " and (PalabrasClave like ");
				set @pos = instr(@cadena,',');
				if @pos = 0 then
					set @criterio = concat(@criterio, "'%", @cadena, "%'");
					set @cadena = null;
				else
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, "'%", @crit, "%'");
				end if;
				while instr(@cadena, ', ') <> 0 do
					set @pos = instr(@cadena,' ');
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
				end while;
				if @cadena is not null then
					set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
				else
					set @criterio = concat(@criterio, ")");
				end if;
			end if;
			if claveno is not null then
				set @cadena = claveno;
				set @criterio = concat(@criterio, " and (PalabrasClave not like ");
				set @pos = instr(@cadena,',');
				if @pos = 0 then
					set @criterio = concat(@criterio, "'%", @cadena, "%'");
					set @cadena = null;
				else
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, "'%", @crit, "%'");
				end if;
				while instr(@cadena, ', ') <> 0 do
					set @pos = instr(@cadena,' ');
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
				end while;
				if @cadena is not null then
					set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
				else
					set @criterio = concat(@criterio, ")");
				end if;
			end if;
			set @reser = concat('select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where ', @criterio);
		else
			set @reser = 'select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where false';
		end if;
	else
		set @reser = 'select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where false';
	end if;
        select @exito, @reser;
END$$

DROP PROCEDURE IF EXISTS `EstadisticasRevistasSoloReservadas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadisticasRevistasSoloReservadas`(titulo varchar(100), autor varchar(100), clavesi varchar(200), claveno varchar(200), out exito int(11), out reser varchar(1000))
BEGIN
	set @criterio = 'documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1) and documentos.Estado <> 2';
	set @exito = 1;
	if (select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where documentos.Activo = 1 and documentos.Uid in (select UidDocumento from reservas where reservas.Activo = 1)) <> 0 then
		if (autor is null)  then
			if titulo is not null then
				set @criterio = concat(@criterio, " and Titulo like '%", titulo, "%'");
			end if;
			if clavesi is not null then
				set @cadena = clavesi;
				set @criterio = concat(@criterio, " and (PalabrasClave like ");
				set @pos = instr(@cadena,',');
				if @pos = 0 then
					set @criterio = concat(@criterio, "'%", @cadena, "%'");
					set @cadena = null;
				else
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, "'%", @crit, "%'");
				end if;
				while instr(@cadena, ', ') <> 0 do
					set @pos = instr(@cadena,' ');
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, " and PalabrasClave like '%", @crit, "%'");
				end while;
				if @cadena is not null then
					set @criterio = concat(@criterio, " and PalabrasClave like '%", @cadena, "%')");
				else
					set @criterio = concat(@criterio, ")");
				end if;
			end if;
			if claveno is not null then
				set @cadena = claveno;
				set @criterio = concat(@criterio, " and (PalabrasClave not like ");
				set @pos = instr(@cadena,',');
				if @pos = 0 then
					set @criterio = concat(@criterio, "'%", @cadena, "%'");
					set @cadena = null;
				else
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, "'%", @crit, "%'");
				end if;
				while instr(@cadena, ', ') <> 0 do
					set @pos = instr(@cadena,' ');
					set @crit = left(@cadena, @pos-1);
					set @cadena = substring(@cadena,@pos+1);
					set @criterio = concat(@criterio, " and PalabrasClave not like '%", @crit, "%'");
				end while;
				if @cadena is not null then
					set @criterio = concat(@criterio, " and PalabrasClave not like '%", @cadena, "%')");
				else
					set @criterio = concat(@criterio, ")");
				end if;
			end if;
			set @reser = concat('select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where ', @criterio);
		else
			set @reser = 'select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where false';
		end if;
	else
		set @reser = 'select count(*) from documentos inner join revistasperiodicos on documentos.Uid = revistasperiodicos.Uid where false';
	end if;
        select @exito, @reser;
END$$

DROP PROCEDURE IF EXISTS `EstadoBibliotecario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadoBibliotecario`(Id bigint(16), out exito int(11), out salida varchar(100), out certif varchar(2))
BEGIN
	set @exito = 1;
	set @reserva = (select count(*) from reservas where UidPersona = Id);
	set @prest =(select count(*) from prestamos where UidPersona = Id and Activo = 1);
	set @haysan = (select count(*) from prestamos where UidPersona = Id and Activo = 1 and HaySancion = 'Si');
	if (@prest != 0) or (@haysan != 0) then
		set @salida = 'El usuario tiene algún préstamo o sanción pendiente';
		set @certif = 'No';
	else
		if (@reserva != 0) then
			set @salida = 'El usuario sólamente tiene reservas activas. No tiene nada pendiente';
		else
			set @salida = 'El usuario no tiene nada pendiente';
		end if;
		set @certif = 'Si';
	end if;
	select @exito,@salida,@certif;
END$$

DROP PROCEDURE IF EXISTS `EstadoPermitido`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EstadoPermitido`(estant int, estnuevo int, out estperm int)
BEGIN
	set estperm = 0;
	if estant = estnuevo then
		set estperm = 1;
	else
		if (estant = 5 or estant = 1 or estant = 4) and (estnuevo = 5 or estnuevo = 1 or estnuevo = 4) then
			set estperm = 1;
		end if;
	end if;
END$$

DROP PROCEDURE IF EXISTS `FinalizacionReservasDiarias`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `FinalizacionReservasDiarias`(out exito int(11), out salida varchar(50))
BEGIN
	START TRANSACTION;
	set @exito= 1;
	set @salida='ok';
	if (select count(*) from reservas where UidDocumento in (select UidDocumento from prestamos where to_days(date(now())) >= to_days(FechaDevolucion) + (select Valor from configuracion where NombreAtributo ='TiempoSolicita'))) != 0 then
		update documentos
			set Estado = 3
		where Uid in (select UidDocumento from prestamos where to_days(date(now())) >= to_days(FechaDevolucion) + (select Valor from configuracion where NombreAtributo = 'TiempoSolicita'));
	else
		update documentos
			set Estado = 1
		where Uid in (select UidDocumento from prestamos where to_days(date(now())) >= to_days(FechaDevolucion) + (select Valor from configuracion where NombreAtributo = 'TiempoSolicita'));
	end if;
	delete from reservas where reservas.UidDocumento in (select UidDocumento from prestamos where to_days(date(now())) >= to_days(FechaFin) + (select Valor from configuracion where NombreAtributo='TiempoSolicita')) order by reservas.FechaInicio limit 1;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `IdentificarUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `IdentificarUsuario`(usuar varchar(45), pass varchar(45), tipousuar enum ('Contable','Administrativo','TEDECO','Profesor','TEDECO','Decano','Bibliotecario'), out exito int(11), out salida varchar(100))
BEGIN
	START TRANSACTION;
	if (usuar is null) then
		set @exito = 0;
		set @salida = 'Tiene que introducir usuario, contraseña y tipo de usuario';
	else
		set @usu = (select Usuario from usuarios where Usuario = usuar and TipoUsuario = tipousuar and Activo = 1);
		if (@usu is null) then
			set @salida = 'No existe el usuario o el tipo de usuario es incorrecto';
			set @exito = 0;
		else
			set @contra = (select Contrasena from usuarios where Usuario = usuar and TipoUsuario = tipousuar and Activo = 1);
			if (@contra <> pass) then
				set @salida = 'Contraseña incorrecta';
				set @exito = 0;
			else
				set @exito = 1;
				set @salida = (select Uid from usuarios where Usuario = usuar and TipoUsuario = tipousuar and Activo = 1);
			end if;
		end if;
	end if;
	if @exito = 0 then
		ROLLBACK;
	else
		COMMIT;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `LibrosPrestadosA`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `LibrosPrestadosA`(Id bigint(16), out exito int(11), out salida varchar(100), out cantidad int(11), out sele varchar(900))
BEGIN
	set @exito = 1;
	set @salida = 'Los libros prestados son';
	if Id is null then
		set @exito = 0;
		set @salida = 'Tiene que elegir a una persona';
		set @cantidad = 0;
		set @sele = 'select * from documentos where false';
	else
		set @cantidad = (select count(*) from documentos, kumenya_matriculacion.personas, prestamos, libros where documentos.Uid = libros.Uid and libros.Uid = prestamos.UidDocumento and kumenya_matriculacion.personas.Uid=Id and prestamos.UidPersona=Id);
		set @sele = concat('select documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos, libros where documentos.Uid = libros.Uid and libros.Uid=prestamos.UidDocumento and kumenya_matriculacion.personas.Uid=',Id,' and prestamos.UidPersona=',Id);
	end if;
	select @exito, @salida, @cantidad, @sele;
END$$

DROP PROCEDURE IF EXISTS `LibrosPrestadosDurante`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `LibrosPrestadosDurante`(fecini varchar(15), fecfin varchar(15), out exito int(11), out salida varchar(100), out cantidad int(11), out sele varchar(900))
BEGIN
	set @exito = 1;
	set @cantidad = 0;
	set @salida = 'Los libros prestados son';
	if (fecini is null) and (fecfin is null) then
		set @cantidad = (select count(*) from documentos, kumenya_matriculacion.personas, prestamos, libros where documentos.Uid = libros.Uid and libros.Uid = prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona);
		set @sele = 'select documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos, libros where documentos.Uid = libros.Uid and libros.Uid=prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona';
	else
		if (fecini is not null) and (fecfin is null) then
			set @valini = ValidarFecha(fecini);
			if @valini = 0 then
				set @salida = 'La fecha de inicio no es válida';
			else
				set @cantidad = (select count(*) from documentos, kumenya_matriculacion.personas, prestamos, libros where documentos.Uid = libros.Uid and libros.Uid = prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.FechaInicio >= fecini);
				set @sele =concat("select documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos, libros where documentos.Uid = libros.Uid and libros.Uid=prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.FechaInicio >='", fecini,"'");
			end if;
		else
			if (fecini is null) and (fecfin is not null) then
				set @valfin = ValidarFecha(fecfin);
				if @valfin = 0 then
					set @salida = 'La fecha de fin no es válida';
				else
					set @cantidad = (select count(*) from documentos, kumenya_matriculacion.personas, prestamos, libros where documentos.Uid = libros.Uid and libros.Uid = prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.FechaFin <= fecfin);
					set @sele = concat("select documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos, libros where documentos.Uid = libros.Uid and libros.Uid=prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.FechaFin <= '",fecfin,"'");
				end if;
			else
				set @valini = ValidarFecha(fecini);
				if @valini = 0 then
					set @salida = 'La fecha de inicio no es válida';
				else
					set @valfin =ValidarFecha(fecfin);
					if @valfin = 0 then
						set @salida = 'La fecha de fin no es válida';
					else
						set @cantidad = (select count(*) from documentos, kumenya_matriculacion.personas, prestamos, libros where documentos.Uid = libros.Uid and libros.Uid = prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.FechaInicio >= fecini and prestamos.FechaFin <= fecfin);
						set @sele = concat("select documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos, libros where documentos.Uid = libros.Uid and libros.Uid=prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.FechaInicio >= '",fecini,"' and  prestamos.FechaFin <= '",fecfin,"'");
					end if;
				end if;
			end if;
		end if;
	end if;
	select @exito, @salida, @cantidad, @sele;
END$$

DROP PROCEDURE IF EXISTS `ModificacionDeArticulo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeArticulo`(Id bigint(16),Titulo varchar(100), Signatura varchar(14), Volumen varchar(15), Observaciones varchar(100), Traductor varchar(50), PalabrasClave varchar(200), Idioma varchar(11), Estado varchar(11), Autor varchar(80), NombreFuente varchar(100), Fasciculo varchar(11), Pagina varchar(11), CodigoFuente varchar(10), OUT exito int(11), OUT salida varchar(100))
BEGIN
	START TRANSACTION;
	if (Id is null) or (Titulo is null)  or (Signatura is null) or (Idioma is null) or (Estado is null) or (Autor is null) or (NombreFuente is null) or (Pagina is null) or (CodigoFuente is null) then
		set @exito = 0;
		set @vacios = ValidarNullModificacionArticulo(Id, Titulo, Signatura, Idioma, Estado, Autor, NombreFuente, Pagina, CodigoFuente);
		set @tipos = ValidarArticulo(Fasciculo, Pagina);
		set @salida = concat(trim(@vacios), '. ', trim(@tipos));
	else
		set @salida = ' ';
		set @salida = ValidarArticulo(Fasciculo, Pagina);
		if @salida <> ' ' then
			set @exito = 0;
			set @salida = trim(salida);
		else
			set @estant = (select documentos.Estado from documentos where Uid = Id);
			call EstadoPermitido (@estant, Estado, @estpermitido);
			if (@estpermitido = 1) then
				call ModificacionDeDocumento (Id,Titulo, Signatura, Volumen, Observaciones, Traductor, PalabrasClave, Idioma, Estado);
				update articulos
					set Autor = Autor,
					NombreFuente = NombreFuente,
					Fasciculo = Fasciculo,
					Pagina = Pagina,
					CodigoFuente = CodigoFuente
				where Uid = Id;
				set @exito = 1;
				set @salida = 'Se ha modificado el registro';
			else
				set @exito = 0;
				set @salida = 'Estado no permitido';
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `ModificacionDeDocumento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeDocumento`(Id bigint(16), Titulo varchar(100), Signatura varchar(14), Volumen varchar(15), Observaciones varchar(100), Traductor varchar(50), PalabrasClave varchar(200), Idioma int, Estado int)
BEGIN
	update documentos
		set Titulo = Titulo,
		Signatura = Signatura,
		Volumen = Volumen,
		Observaciones = Observaciones,
		Traductor = Traductor,
		PalabrasClave = PalabrasClave,
		Idioma = Idioma,
		Estado = Estado,
		FechaModificacion = now()
	where Uid = id;
END$$

DROP PROCEDURE IF EXISTS `ModificacionDeLibro`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeLibro`(Id bigint(16), Titulo varchar(100), Signatura varchar(14), Volumen varchar(4), Observaciones varchar(100), Traductor varchar(50), PalabrasClave varchar(200), Idioma int, Estado int, Autor varchar(80), DireccionPub varchar(100), Editorial varchar(80), Procedencia varchar(100), ISBN varchar(25), OUT exito int(11), OUT salida varchar(100))
BEGIN
	START TRANSACTION;
	if (Id is null) or (Titulo is null)  or (Signatura is null) or (Idioma is null) or (Estado is null) or (Autor is null) then
		set @exito = 0;
		set @salida = trim(ValidarNullModificacionLibro(Id,Titulo, Signatura, Idioma, Estado, Autor));
	else
		set @estant = (select documentos.Estado from documentos where Uid = Id);
		call EstadoPermitido (@estant, Estado, @estpermitido);
		if (@estpermitido = 1) then
			call ModificacionDeDocumento (Id,Titulo, Signatura, Volumen, Observaciones, Traductor, PalabrasClave, Idioma, Estado);
			update libros
				set Autor = Autor,
				DireccionPub = DireccionPub,
				Editorial = Editorial,
				Procedencia = Procedencia,
				ISBN = ISBN
			where Uid = Id;
			set @exito = 1;
			set @salida = 'Se ha modificado el registro';
		else
			set @exito = 0;
			set @salida = 'Estado no permitido';
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `ModificacionDePrestamo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDePrestamo`(uiddoc bigint(16), document bigint(16), person bigint(16), out exito int(11), out salida varchar(200))
BEGIN
	START TRANSACTION;
if ((select count(*) from prestamos where Uid = uiddoc and Activo=1) = 0) then
	set @salida='No existe el préstamo';
	set @exito = 0;
else
	set @perAnt = (select UidPersona from prestamos where Uid=uiddoc and Activo = 1);
	set @docAnt = (select UidDocumento from prestamos where Uid=uiddoc and Activo = 1);
	set @estado = (select Estado from documentos where Uid = document);
	set @personaReserva = (select UidPersona from reservas where UidDocumento = document ORDER BY FechaCreacion LIMIT 1);
	set @per = (select count(*) from prestamos where Activo = 1 and HaySancion = 'Si' and UidPersona = person);
	set @numMax = ((select Valor from configuracion where NombreAtributo ='TiempoSolicita') - (select count(*) from prestamos where UidPersona = person and Activo=1));
	if (@perAnt = person) and (@docAnt = document) then
		set @salida = 'No ha habido cambios';
		set @exito = 1;
	else
		if (@perAnt = person) and (@docAnt <> document) then
			if (@estado = 1) or ((@personaReserva = person) and (@estado = 3)) then
				update prestamos
					set UidDocumento = document,
					UidPersona = person,
					FechaInicio = now(),
					FechaFin = date_add(now(),interval(select Valor from configuracion where NombreAtributo = 'TiempoPrestamo') day),
					Activo = 1,
					FechaModificacion = now()
				where Uid = uiddoc;
				if (@estado = 3) and (@personaReserva = person) then
					delete from reservas where UidPersona = person and UidDocumento = document;
				end if;
				update documentos
					set Estado = 1
				where (Uid = @docAnt) and ((select UidPersona from reservas where UidDocumento=@docAnt) is null);
				update documentos
					set Estado = 3
				where (Uid = @docAnt) and ((select UidPersona from reservas where UidDocumento=@docAnt) is not null);
				update documentos
					set Estado = 2
				where Uid = document;
				set @salida = 'Se ha modificado el registro';
				set @exito = 1;
			else
				set @exito = 0;
				if (@estado = 3) and ((@personaReserva <> person) and (@personaReserva is not null)) then
					set @salida = 'Documento reservado por otro usuario';
				else
					if (@estado = 2) then
						set @salida = 'El documento está prestado';
					else
						set @salida = 'El estado del documento no permite que sea prestado';
					end if;
				end if;
			end if;
		else
			if (@docAnt = document) and (@perAnt <> person) then
				if (@per = 0) and (@numMax > 0) and ((@personaReserva = person) or (@personaReserva is null)) then
					update prestamos
						set UidDocumento = document,
						UidPersona = person,
						FechaInicio = now(),
						FechaFin = date_add(now(),interval(select Valor from configuracion where NombreAtributo = 'TiempoPrestamo') day),
						Activo = 1,
						FechaModificacion = now()
					where Uid = uiddoc;
					if (@personaReserva = person) then
						delete from reservas where UidPersona = person and UidDocumento = document;
					end if;
					set @exito =1;
					set @salida = 'Se ha modificado el registro';
				else
					set @exito = 0;
					if (@per <> 0) then
						set @salida = 'El usuario tiene una sanción pendiente';
					else
						if (@numMax = 0) then
							set @salida = 'El usuario tiene el número máximo de préstamos posibles';
						else
							if (@personaReserva <> person) and (@personaReserva is not null) then
								set @salida = 'Documento reservado por otro usuario';
							end if;
						end if;
					end if;
				end if;
			else
				if (@docAnt <> document) and (@perAnt <> person) then
					delete from prestamos where Uid = uiddoc;
					set @reservaAnt = (select count(*) from reservas where UidDocumento = @docAnt);
					if (@reservaAnt > 0) then
						update documentos
							set Estado = 3
						where Uid = @docAnt;
					else
						update documentos
							set Estado = 1
						where Uid = @docAnt;
					end if;
					call AltaDePrestamo(document,person,@exito,@salida);
				end if;
			end if;
		end if;
	end if;
end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
END$$

DROP PROCEDURE IF EXISTS `ModificacionDeReserva`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeReserva`(uidres bigint(16), document bigint(16), person bigint(16), out exito int(11), out salida varchar(200))
BEGIN
	START TRANSACTION;
	if ((select count(*) from reservas where Uid = uidres) = 0) then
		set @salida='No existe la reserva';
		set @exito = 0;
	else
		set @per = (select count(*) from prestamos where Activo = 1 and HaySancion = 1 and UidPersona = person);
		set @doc = (select count(*) from prestamos where UidDocumento = document and Activo=1);
		set @num = (select count(*) from reservas where UidDocumento = document and UidPersona = person) + (select count(*) from prestamos where UidDocumento = document and UidPersona = person and Activo = 1);
		set @estado = (select estado from documentos where Uid= document);
		set @personaReserva = (select UidPersona from reservas where UidDocumento = document ORDER BY FechaCreacion LIMIT 1);
		set @perAnt = (select UidPersona from reservas where Uid=uidres);
		set @docAnt = (select UidDocumento from reservas where Uid=uidres);
		if (document=@docAnt) and (person=@perAnt) then
			set @exito =1;
			set @salida = 'No ha habido cambios';
		else
			if (document = @docAnt) and (person <> @perAnt) then
				if (@per = 0) and (@num = 0) and ((@estado=2 and @doc >0) or (@estado = 3)) then
					UPDATE reservas
						SET
							UidDocumento = document,
							UidPersona = person,
							FechaInicio = now(),
							Activo = 1,
							FechaModificacion = now()
					WHERE Uid= uidres;
					set @salida = 'Se ha modificado el registro';
					set @exito =1;
				else
					if (@per <> 0) then
						set @salida = 'El usuario tiene una sanción pendiente';
						set @exito = 0;
					else
						if (@num <> 0) then
							set @salida = 'Documento reservado o prestado por el usuario';
							set @exito = 0;
						else
							if (@estado <> 2 and @estado <> 3) then
								set @salida = 'El estado del documento no permite que sea reservado';
								set @exito = 0;
							end if;
						end if;
					end if;
				end if;
			else
				if(document <> @docAnt) and (person = @perAnt) then
					if (@per = 0) and (@num = 0) and ((@estado=2 and @doc >0) or (@estado = 3)) then
						UPDATE reservas
							SET
								UidDocumento = document,
								UidPersona = person,
								FechaInicio = now(),
								Activo = 1,
								FechaModificacion = now()
						WHERE Uid= uidres;
						if (select count(*) from prestamos where UidDocumento = @docAnt and Activo = 1) = 0 then
							if (select count(*) from reservas where UidDocumento = @docAnt) = 0 then
								update documentos set Estado = 1 where Uid = @docAnt;
							else
								update documentos set Estado = 3 where Uid = @docAnt;
							end if;
						else
							update documentos set Estado = 2 where Uid = @docAnt;
						end if;
						set @salida = 'Se ha modificado el registro';
						set @exito =1;
					else
						if (@per <> 0) then
							set @salida = 'El usuario tiene una sanción pendiente';
							set @exito = 0;
						else
							if (@num <> 0) then
								set @salida = 'Documento reservado o prestado por el usuario';
								set @exito = 0;
							else
								if (@estado <> 2 and @estado <> 3) then
									set @salida = 'El estado del documento no permite que sea reservado';
									set @exito = 0;
								end if;
							end if;
						end if;
					end if;
				else
					if (document <> @docAnt) and (person <> @perAnt) then
						delete from reservas where Uid = uidres;
						if (select count(*) from prestamos where UidDocumento = @docAnt and Activo = 1) = 0 then
							if (select count(*) from reservas where UidDocumento = @docAnt) = 0 then
								update documentos set Estado = 1 where Uid = @docAnt;
							else
								update documentos set Estado = 3 where Uid = @docAnt;
							end if;
						else
							update documentos set Estado = 2 where Uid = @docAnt;
						end if;
						call AltaDeReserva(document,person,@exito,@salida);
					end if;
				end if;
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `ModificacionDeRevista`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeRevista`(Id bigint(16),Titulo varchar(100), Signatura varchar(14), Volumen varchar(15), Observaciones varchar(100), Traductor varchar(50), PalabrasClave varchar(200),Idioma int, Estado int, Editor varchar(80), Numero varchar(10), DireccionPub varchar(100), FechaSuscripcion varchar(15), Frecuencia varchar(10), Fasciculo varchar(10), AnioPub varchar(10), EsRevista enum('Revista','Periodico'), OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	if (Id is null) or (Titulo is null)  or (Signatura is null) or (Idioma is null) or (Estado is null) or (Numero is null) or (Frecuencia is null) or (AnioPub is null) or (EsRevista is null) then
		set @exito = 0;
		set @vacios = ValidarNullAltaRevista(Titulo, Signatura, Idioma, Estado, Numero, Frecuencia, AnioPub, EsRevista);
		set @tipos = ValidarRevista(Numero, FechaSuscripcion, Frecuencia, Fasciculo, AnioPub);
		set @salida = concat(trim(@vacios), '. ', trim(@tipos));
	else
		set @salida = ' ';
		set @salida = ValidarRevista(Numero, FechaSuscripcion, Frecuencia, Fasciculo, AnioPub);
		if @salida <> ' ' then
			set @exito = 0;
			set @salida = trim(salida);
		else
		set @estant = (select documentos.Estado from documentos where Uid = Id);
		call EstadoPermitido (@estant, Estado, @estpermitido);
		if (@estpermitido = 1) then
				call ModificacionDeDocumento (Id,Titulo, Signatura, Volumen, Observaciones, Traductor, PalabrasClave, Idioma, Estado);
				update revistasperiodicos
					set Editor = Editor,
					Numero = Numero,
					DireccionPub = DireccionPub,
					FechaSuscripcion =str_to_date(cast(FechaSuscripcion as char),'%Y-%m-%d'),
					Frecuencia = Frecuencia,
					Fasciculo = Fasciculo,
					AnioPub = AnioPub,
					EsRevista = EsRevista
				where Uid = Id;
				set @exito = 1;
				set @salida = 'Se ha modificado el registro';
			else
				set @exito = 0;
				set @salida = 'Estado no permitido';
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `ModificacionDeUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeUsuario`(Id bigint, usuar varchar(45), pass varchar(45), person bigint, tipousuar enum ('Contable','Administrativo','TEDECO','Profesor','Decano','Bibliotecario'), out exito int(11), out salida varchar(100))
BEGIN
	START TRANSACTION;
	if (usuar is null) or (pass is null) or (person is null) or (tipousuar is null) or (Id is null) then
		set @exito = 0;
		set @salida = ValidarNullModificacionUsuario (Id,usuar, pass, person, tipousuar);
	else
		set @per = (select Uid from kumenya_matriculacion.personas where Uid = person and Activo = 1);
		if (@per is null) then
			set @salida = 'No existe la persona seleccionada';
			set @exito = 0;
		else
			if (select count(*) from usuarios where TipoUsuario = tipousuar and Uid != Id and Usuario = usuar and Activo = 1) > 0 then
				set @exito = 0;
				set @salida = 'Ya existe el usuario y rol seleccionados';
			else
				update usuarios
					set Uid = Id,
					Usuario = usuar,
					Contrasena = pass,
					Persona = person,
					TipoUsuario = tipousuar,
					FechaModificacion = now()
				where Uid = Id;
				set @exito = 1;
				set @salida = 'Se ha modificado el registro';
			end if;
		end if;
	end if;
	if (@exito = 0) then
		ROLLBACK;
	else
		COMMIT;
	end if;
	select @exito, @salida;
END$$

DROP PROCEDURE IF EXISTS `ModificacionParametrosRoot`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionParametrosRoot`(Ident bigint(16), Atributo varchar(50), Value varchar(50), OUT exito int(11), OUT salida varchar(200))
BEGIN
	START TRANSACTION;
	set @exito = 1;
	set @salida = 'Se ha modificado el registro';


	if (select Modificable from configuracion where Uid = Ident) = 'Si' then
		update configuracion
			set Valor = Value
		where Uid = Ident;
	else
		set @exito = 0;
		set @salida = 'Parámetro no modificable';
	end if;

	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `MostrarCamposPrestamo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarCamposPrestamo`()
begin
select column_name, table_name, table_schema from information_schema.`COLUMNS` where ((table_name='documentos' or table_name='personas')  and column_name in ('Uid', 'Nombre', 'Apellidos','TipoPersona','Titulo','Estado','CodigoPersona','Signatura')) or table_name='prestamos' and column_name in ('FechaInicio', 'FechaFin');
end$$

DROP PROCEDURE IF EXISTS `MostrarCamposReserva`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarCamposReserva`()
begin
select column_name, table_name, table_schema from information_schema.`COLUMNS` where (table_name='personas' or table_name='documentos' or table_name='reservas')  and column_name in ('Uid', 'Nombre', 'Apellidos','TipoPersona','Titulo','Estado','CodigoPersona','Signatura','FechaInicio');
end$$

DROP PROCEDURE IF EXISTS `MostrarCamposUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarCamposUsuario`()
BEGIN
	select column_name, table_name, table_schema from information_schema.`COLUMNS` where ((table_name='usuarios' or table_name='personas')  and column_name in ('Usuario','Contrasena','TipoUsuario','Uid', 'Nombre', 'Apellidos'));
END$$

DROP PROCEDURE IF EXISTS `PrestamosConSancionPersona`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PrestamosConSancionPersona`(Id bigint(16), out exito int(11), out seleccion varchar(800))
begin
	set @exito = 1;
	if Id is null then
		set @seleccion = 'select prestamos.Uid, documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos where documentos.Uid = prestamos.UidDocumento and prestamos.UidPersona = kumenya_matriculacion.personas.Uid and HaySancion = "Si"';
	else
		set @seleccion = concat('select prestamos.Uid, documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos where documentos.Uid = prestamos.UidDocumento and kumenya_matriculacion.personas.Uid=',Id,' and prestamos.UidPersona=',Id, ' and HaySancion = "Si"');
	end if;
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `ProrrogaDePrestamo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ProrrogaDePrestamo`(uidpres bigint(16), out exito int(11), out salida varchar(200))
BEGIN
	START TRANSACTION;
	if (select count(*) from prestamos where Uid=uidpres and Activo = 1) != 0 then
		if (select FechaFin from prestamos where Uid=uidpres and Activo = 1) < (now()) then
			set @salida = "No se puede prorrogar el préstamo porque se entrega fuera de plazo";
			set @exito = 0;
		else
			set @salida = "No se puede prorrogar más el préstamo";
			
			set @doc = (select UidDocumento from prestamos where Uid = uidpres and Activo = 1);
			if (select count(*) from reservas where UidDocumento = @doc) > 0 then
				
				set @salida = 'El documento está reservado. No se puede prorrogar el préstamo';
				set @exito = 0;
			else
				if (select datediff((select FechaFin from prestamos where Uid=uidpres and Activo = 1), (select FechaInicio from prestamos where Uid=uidpres and Activo = 1))   <=   (select Valor from configuracion where NombreAtributo = 'TiempoPrestamo') + 1) then
					update prestamos
						set FechaFin= date_add(now(), interval (select Valor from configuracion where NombreAtributo = 'TiempoPrestamo') day )
					where Uid=uidpres;
					set @salida = "Préstamo prorrogado";
					set @exito = 1;
				end if;
			end if;
		end if;
	else
		set @salida = "No existe el préstamo";
		set @exito = 0;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
END$$

DROP PROCEDURE IF EXISTS `RevistasPrestadasA`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `RevistasPrestadasA`(Id bigint(16), out exito int(11), out salida varchar(100), out cantidad int(11), out sele varchar(900))
BEGIN
	set @exito = 1;
	set @salida = 'Los periódicos y revistas prestados son';
	if Id is null then
		set @exito = 0;
		set @salida = 'Tiene que elegir a una persona';
		set @cantidad = 0;
		set @sele = 'select * from documentos where false';
	else
		set @cantidad = (select count(*) from documentos, kumenya_matriculacion.personas, prestamos, revistasperiodicos where documentos.Uid =  revistasperiodicos.Uid and  revistasperiodicos.Uid = prestamos.UidDocumento and kumenya_matriculacion.personas.Uid=Id and prestamos.UidPersona=Id);
		set @sele = concat('select documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos,  revistasperiodicos where documentos.Uid =  revistasperiodicos.Uid and  revistasperiodicos.Uid=prestamos.UidDocumento and kumenya_matriculacion.personas.Uid=',Id,' and prestamos.UidPersona=',Id);
	end if;
	select @exito, @salida, @cantidad, @sele;
END$$

DROP PROCEDURE IF EXISTS `RevistasPrestadasDurante`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `RevistasPrestadasDurante`(fecini varchar(15), fecfin varchar(15), out exito int(11), out salida varchar(100), out cantidad int(11), out sele varchar(800))
BEGIN
	set @exito = 1;
	set @cantidad = 0;
	set @salida = 'Los periódicos y revistas prestados son';
	if (fecini is null) and (fecfin is null) then
		set @cantidad = (select count(*) from documentos, kumenya_matriculacion.personas, prestamos, revistasperiodicos where documentos.Uid =  revistasperiodicos.Uid and  revistasperiodicos.Uid = prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona);
		set @sele = 'select documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos,  revistasperiodicos where documentos.Uid =  revistasperiodicos.Uid and  revistasperiodicos.Uid=prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona';
	else
		if (fecini is not null) and (fecfin is null) then
			set @valini = ValidarFecha(fecini);
			if @valini = 0 then
				set @salida = 'La fecha de inicio no es válida';
			else
				set @cantidad = (select count(*) from documentos, kumenya_matriculacion.personas, prestamos,  revistasperiodicos where documentos.Uid =  revistasperiodicos.Uid and  revistasperiodicos.Uid = prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.FechaInicio >= fecini);
				set @sele =concat("select documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos,  revistasperiodicos where documentos.Uid =  revistasperiodicos.Uid and  revistasperiodicos.Uid=prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.FechaInicio >= '",fecini,"'");
			end if;
		else
			if (fecini is null) and (fecfin is not null) then
				set @valfin = ValidarFecha(fecfin);
				if @valfin = 0 then
					set @salida = 'La fecha de fin no es válida';
				else
					set @cantidad = (select count(*) from documentos, kumenya_matriculacion.personas, prestamos,  revistasperiodicos where documentos.Uid =  revistasperiodicos.Uid and  revistasperiodicos.Uid = prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.FechaFin <= fecfin);
					set @sele = concat("select documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos,  revistasperiodicos where documentos.Uid =  revistasperiodicos.Uid and  revistasperiodicos.Uid=prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.FechaFin <= '",fecfin,"'");
				end if;
			else
				set @valini = ValidarFecha(fecini);
				if @valini = 0 then
					set @salida = 'La fecha de inicio no es válida';
				else
					set @valfin =ValidarFecha(fecfin);
					if @valfin = 0 then
						set @salida = 'La fecha de fin no es válida';
					else
						set @cantidad = (select count(*) from documentos, kumenya_matriculacion.personas, prestamos,  revistasperiodicos where documentos.Uid =  revistasperiodicos.Uid and  revistasperiodicos.Uid = prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.FechaInicio >= fecini and prestamos.FechaFin <= fecfin);
						set @sele = concat("select documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, prestamos.FechaInicio, prestamos.FechaFin, prestamos.FechaDevolucion, prestamos.HaySancion from documentos, kumenya_matriculacion.personas, prestamos,  revistasperiodicos where documentos.Uid =  revistasperiodicos.Uid and  revistasperiodicos.Uid=prestamos.UidDocumento and kumenya_matriculacion.personas.Uid = prestamos.UidPersona and prestamos.FechaInicio >= '",fecini,"' and  prestamos.FechaFin <= '",fecfin,"'");
					end if;
				end if;
			end if;
		end if;
	end if;
	select @exito, @salida, @cantidad, @sele;
END$$

DROP PROCEDURE IF EXISTS `SancionDocumentosNoDevueltos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SancionDocumentosNoDevueltos`(out exito int(11), out salida varchar(50))
begin
	START TRANSACTION;
	set @exito= 1;
	set @salida='ok';
	if (select count(*) from prestamos where Activo = 1 and FechaDevolucion is null and FechaFin < now() and HaySancion = 'No') > 0 then
		update prestamos set
			HaySancion = 1
		where Activo = 1 and FechaDevolucion is null and FechaFin < now() and HaySancion = 'No';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

--
-- Funciones
--
DROP FUNCTION IF EXISTS `SiguienteCodigo`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `SiguienteCodigo`(tipoper enum ('Alumno','PAS','Profesor')) RETURNS varchar(10) CHARSET latin1
BEGIN
	if tipoper = 'Alumno' then
		set @codigo = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'UltimoCodigoAlumno');
		set @crit = 'UltimoCodigoAlumno';
	else
		if tipoper = 'PAS' then
			set @codigo = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'UltimoCodigoPAS');
			set @crit = 'UltimoCodigoPAS';
		else
			set @codigo = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'UltimoCodigoProfesor');
			set @crit = 'UltimoCodigoProfesor';
		end if;
	end if;
	set @inicio = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'FechaInicioCurso');
	if now() >= @inicio then
    set @tipo = mid(@codigo,1,1);
		set @siganio = right(concat('00',(mid(@codigo,2,3) + 1)),2);
return mid(@codigo,2,3);
		set @nuevo = concat(@tipo,@siganio,'0001');
		update kumenya_biblioteca.configuracion
			set Valor = concat(year(now()),'-10-01')
		where
			NombreAtributo='FechaInicioCurso';
  else
  	set @tipo = mid(@codigo,1,3);
	  set @sigcod = mid(@codigo,5,3) + 1;
  	set @sigcodigo = right(concat('0000',@sigcod),4);
	  set @nuevo = concat(@tipo,@sigcodigo);
	end if;
	update kumenya_biblioteca.configuracion set Valor = @nuevo where NombreAtributo = @crit;
	return @nuevo;
END$$

DROP FUNCTION IF EXISTS `ValidarAnio`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarAnio`(entrada varchar(20)) RETURNS int(11)
BEGIN
	if @anito < 0 then
		return 0;
	else
		set @anito = cast(entrada as unsigned);
		if @anito then
			if (@anito > 0 and @anito <= 2155) then
				return 1;
			else
				return 0;
			end if;
		else
			return 0;
		end if;
	end if;
END$$

DROP FUNCTION IF EXISTS `ValidarArticulo`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarArticulo`(Fasciculo varchar(10),Pagina varchar(10)) RETURNS varchar(400) CHARSET latin1
BEGIN
	set @fas=1;
	set @pag=1;
	if Fasciculo is not null then
		set @fas = ValidarInteger(Fasciculo);
	end if;
	if Pagina is not null then
		set @pag = ValidarInteger(Pagina);
	end if;
	set @resul=' ';
	if (@fas * @pag = 0) then
		set @resul = 'Informacion no correcta: ';
		if @fas = 0 then
			set @resul = concat(@resul, "'", Fasciculo, "' ");
		end if;
		if @pag = 0 then
			set @resul = concat(@resul, "'", Pagina, "'");
		end if;
	end if;
	return @resul;
END$$

DROP FUNCTION IF EXISTS `ValidarBit`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarBit`(entrada varchar(10)) RETURNS int(11)
BEGIN
	if (entrada = '0') or (entrada = '1') then
		return 1;
	else
		return 0;
	end if;
END$$

DROP FUNCTION IF EXISTS `ValidarDocumento`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarDocumento`(Idioma varchar(10), Estado varchar(10)) RETURNS varchar(100) CHARSET latin1
BEGIN
	set @resul = ' ';
	set @idi = ValidarInteger(Idioma);
	set @est = ValidarInteger(Estado);
	if (@idi * @est = 0) then
		if @idi = 0 then
			set @resul = concat(@resul,'Informacion erronea: "',Idioma,'"');
		end if;
		if @est = 0 then
			set @resul = concat(@resul,', "',Estado,'".');
		end if;
	end if;
	return @resul;
END$$

DROP FUNCTION IF EXISTS `ValidarFecha`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarFecha`(entrada varchar(20)) RETURNS int(11)
BEGIN
	set @fecha=str_to_date(entrada,'%Y-%m-%d');
	if cast(@fecha as date)  then
		return 1;
	else
		return 0;
	end if;
END$$

DROP FUNCTION IF EXISTS `ValidarInteger`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarInteger`(entrada varchar(10)) RETURNS int(11)
BEGIN
	if entrada < 0 then
		return 0;
	else
		if cast(entrada as unsigned) then
			return 1;
		else
			if (entrada = '0') then
				return 1;
			else
				return 0;
			end if;
		end if;
	end if;
END$$

DROP FUNCTION IF EXISTS `ValidarLibro`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarLibro`(Autor varchar(80)) RETURNS varchar(100) CHARSET latin1
BEGIN
	set @aut = ValidarNull(Autor);
	set @resul = ' ';
	if (@aut = 0) then
		set @resul ='Campo obligatorio vacios';
	end if;
	return @resul;
END$$

DROP FUNCTION IF EXISTS `ValidarNull`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarNull`(entrada varchar(100)) RETURNS int(11)
BEGIN
	if entrada is null then
		return 0;
	else
		return 1;
	end if;
END$$

DROP FUNCTION IF EXISTS `ValidarNullAltaArticulo`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarNullAltaArticulo`(Titulo varchar(100), Signatura varchar(14), Idioma int, Estado int, Autor varchar(80), NombreFuente varchar(100), Pagina varchar(10), CodigoFuente varchar(10)) RETURNS varchar(400) CHARSET latin1
BEGIN
	set @tit = ValidarNull(Titulo);
	set @cod = ValidarNull(Signatura);
	set @idi = ValidarNull(Idioma);
	set @est = ValidarNull(Estado);
	set @aut = ValidarNull(Autor);
	set @nomf = ValidarNull(NombreFuente);
	set @pag = ValidarNull(Pagina);
	set @codf = ValidarNull(CodigoFuente);
	set @resul = ' ';
	if (@tit * @cod * @idi * @est * @aut * @nomf * @pag * @codf = 0) then
		set @resul ="Campos obligatorios sin informacion: ";
		if @tit = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre='AltaDeArticulo')  and Orden = 1);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @cod = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre = 'AltaDeArticulo') and Orden = 2);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @idi = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre = 'AltaDeArticulo') and Orden = 7);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @est = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre = 'AltaDeArticulo') and Orden = 8);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @aut = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre = 'AltaDeArticulo') and Orden = 9);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @nomf = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre = 'AltaDeArticulo') and Orden = 10);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @pag = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre = 'AltaDeArticulo') and Orden = 12);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @codf = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre = 'AltaDeArticulo') and Orden = 13);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
	end if;
	return @resul;
END$$

DROP FUNCTION IF EXISTS `ValidarNullAltaLibro`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarNullAltaLibro`(Titulo varchar(50), Signatura varchar(14), Idioma integer, Estado integer, Autor varchar(50)) RETURNS varchar(400) CHARSET latin1
BEGIN
	set @resul = ' ';
	set @tit = ValidarNull(Titulo);
	set @cod = ValidarNull(Signatura);
	set @idi = ValidarNull(Idioma);
	set @est = ValidarNull(Estado);
	set @aut = ValidarNull(Autor);
	if (@tit * @cod * @idi * @est * @aut = 0) then
		set @resul ="'Campos obligatorios sin informacion: ";
		if @tit = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre='AltaDeLibro')  and Orden = 1);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @cod = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre='AltaDeLibro') and Orden = 2);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @idi = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre='AltaDeLibro') and Orden = 7);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @est = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre='AltaDeLibro') and Orden = 8);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @aut = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre='AltaDeLibro') and Orden = 9);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
	end if;
	return @resul;
END$$

DROP FUNCTION IF EXISTS `ValidarNullAltaRevista`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarNullAltaRevista`(Titulo varchar(100), Signatura varchar(14), Idioma int, Estado int, Numero varchar(10), Frecuencia varchar(10), AnioPub varchar(10), EsRevista enum('Revista','Periodico')) RETURNS varchar(400) CHARSET latin1
BEGIN
	set @tit = ValidarNull(Titulo);
	set @cod = ValidarNull(Signatura);
	set @idi = ValidarNull(Idioma);
	set @est = ValidarNull(Estado);
	set @num = ValidarNull(Numero);
	set @fre = ValidarNull(Frecuencia);
	set @ani = ValidarNull(AnioPub);
	set @rev = ValidarNull(EsRevista);
	set @resul = ' ';
	if (@tit * @cod * @idi * @est * @num * @fre * @ani * @rev = 0) then
		set @resul = "Campos obligatorios sin informacion: ";
		if @tit = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre='AltaDeRevista')  and Orden = 1);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @cod = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre = 'AltaDeRevista') and Orden = 2);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @idi = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre = 'AltaDeRevista') and Orden = 7);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @est = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre = 'AltaDeRevista') and Orden = 8);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @num = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre = 'AltaDeRevista') and Orden = 10);
			set @resul = concat(@resul,"'",@campo,"' ");
		end if;
		if @fre = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre = 'AltaDeRevista') and Orden = 13);
			set @resul = concat(@resul,"'",@campo,"' ");
		end if;
		if @ani = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre = 'AltaDeRevista') and Orden = 15);
			set @resul = concat(@resul,"'",@campo,"' ");
		end if;
		if @rev = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre = 'AltaDeRevista') and Orden = 16);
			set @resul = concat(@resul,"'",@campo,"'");
		end if;
	end if;
	return @resul;
END$$

DROP FUNCTION IF EXISTS `ValidarNullAltaUsuario`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarNullAltaUsuario`(usuar varchar(45), pass varchar(45), person varchar(10), tipousuar enum('Contable','Administrativo','TEDECO','Profesor','Bibliotecario')) RETURNS varchar(200) CHARSET latin1
BEGIN
	set @us = ValidarNull(usuar);
	set @con = ValidarNull(pass);
	set @per = ValidarNull(person);
	set @tip = ValidarNull(tipousuar);
	set @result = ' ';
	if (@us * @con * @per * @tip) = 0 then
		set @resul ="Campos obligatorios sin informacion: ";
		if (@us = 0) then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre='AltaDeUsuario')  and Orden = 1);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @con = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre = 'AltaDeUsuario') and Orden = 2);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @per = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre = 'AltaDeUsuario') and Orden = 4);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @tip = 0 then
			set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre = 'AltaDeArticulo') and Orden = 5);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
	end if;
	return @resul;
END$$

DROP FUNCTION IF EXISTS `ValidarNullModificacionArticulo`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarNullModificacionArticulo`(Id bigint, Titulo varchar(100), Signatura varchar(14), Idioma int, Estado int, Autor varchar(80), NombreFuente varchar(100), Pagina varchar(10), CodigoFuente varchar(10)) RETURNS varchar(200) CHARSET latin1
BEGIN
	set @resul = ValidarNullAltaArticulo(Titulo, Signatura, Idioma, Estado, Autor, NombreFuente, Pagina, CodigoFuente);
	set @id = ValidarNull(Id);
	if @id = 0 then
		set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre='ModificacionDeArticulo')  and Orden = 1);
		if @resul <> ' ' then
			set @resul = concat(trim(@resul), " '", @campo, "'");
		else
			set @resul = trim(concat("'Campos obligatorios sin informacion: ", "'", @campo, "' "));
		end if;
	end if;
	return @resul;
END$$

DROP FUNCTION IF EXISTS `ValidarNullModificacionLibro`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarNullModificacionLibro`(Id bigint, Titulo varchar(100), Signatura varchar(14), Idioma integer, Estado integer, Autor varchar(80)) RETURNS varchar(200) CHARSET latin1
BEGIN
	set @resul = ValidarNullAltaLibro(Titulo, Signatura, Idioma, Estado, Autor);
	set @id = ValidarNull(Id);
	if @id = 0 then
		set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre ='ModificacionDeLibro') and Orden = 1);
		if @resul <> ' ' then
			set @resul = concat(trim(@resul), " '", @campo, "'");
		else
			set @resul = trim(concat("'Campos obligatorios sin informacion: ", "'", @campo, "' "));
		end if;
	else
		set @resul = ' ';
	end if;
	return @resul;
END$$

DROP FUNCTION IF EXISTS `ValidarNullModificacionRevista`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarNullModificacionRevista`(Id bigint, Titulo varchar(100), Signatura varchar(14), Idioma int, Estado int, Editor varchar(80), Numero varchar(10), Frecuencia varchar(10), AnioPub varchar(10), EsRevista enum('Revista','Periodico')) RETURNS varchar(400) CHARSET latin1
BEGIN
	set @resul = ValidarNullAltaRevista(Titulo, Signatura, Idioma, Estado, Numero, Frecuencia, AnioPub, EsRevista);
	set @id = ValidarNull(Id);
	if @id = 0 then
		set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre='ModificacionDeRevista')  and Orden = 1);
		if @resul <> ' ' then
			set @resul = concat(trim(@resul), " '", @campo, "'");
		else
			set @resul = trim(concat("'Campos obligatorios sin informacion: ", "'", @campo, "' "));
		end if;
	end if;
	return @resul;
END$$

DROP FUNCTION IF EXISTS `ValidarNullModificacionUsuario`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarNullModificacionUsuario`(Id bigint, usuar varchar(45), pass varchar(45), person varchar(10), tipousuar enum('Contable','Administrativo','TEDECO','Profesor','Bibliotecario')) RETURNS varchar(400) CHARSET latin1
BEGIN
	set @resul = ValidarNullAltaUsuario (usuar, pass,person,tipousuar);
	set @iden = ValidarNull(Id);
	if @iden = 0 then
		set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre ='ModificacionDeUsuario') and Orden = 1);
		if @resul <> ' ' then
			set @resul = concat(trim(@resul), " '", @campo, "'");
		else
			set @resul = trim(concat("'Campos obligatorios sin informacion: ", "'", @campo, "' "));
		end if;
	else
		set @resul = ' ';
	end if;
	return @resul;
END$$

DROP FUNCTION IF EXISTS `ValidarRev`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarRev`(entrada varchar(10)) RETURNS int(11)
BEGIN
	if (entrada = 'Revista') or (entrada = 'Periodico') then
		return 1;
	else
		return 0;
	end if;
END$$

DROP FUNCTION IF EXISTS `ValidarRevista`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarRevista`(Numero varchar(10), FechaSuscripcion varchar(10), Frecuencia varchar(10), Fasciculo varchar(10), AnioPub varchar(10)) RETURNS varchar(400) CHARSET latin1
BEGIN
	set @num = 1;
	set @fsus = 1;
	set @fre = 1;
	set @fas = 1;
	set @ani = 1;
	set @rev = 1;
	if Numero is not null then
		set @num = ValidarInteger(Numero);
	end if;
	if FechaSuscripcion is not null then
		set @fsus = ValidarFecha(FechaSuscripcion);
	end if;
	if Frecuencia is not null then
		set @fre = ValidarInteger(Frecuencia);
	end if;
	if Fasciculo is not null then
		set @fas = ValidarInteger(Fasciculo);
	end if;
	if AnioPub is not null then
		set @ani = ValidarAnio(AnioPub);
	end if;
	
	set @resul = ' ';
	if (@num * @fsus * @fre * @fas * @ani * @cal * @rev = 0) then
		set @resul = 'Información no correcta: ';
		if @num = 0 then
			set @resul = concat(@resul, "'", Numero, "' ");
		end if;
		if @fsus = 0 then
			set @resul = concat(@resul, "'", FechaSuscripcion, "' ");
		end if;
		if @fre = 0 then
			set @resul = concat(@resul, "'", Frecuencia, "' ");
		end if;
		if @fas = 0 then
			set @resul = concat(@resul, "'", Fasciculo, "' ");
		end if;
		if @ani = 0 then
			set @resul = concat(@resul, "'", AnioPub, "' ");
		end if;
	end if;
	return @resul;
END$$

DELIMITER ;
--
-- Base de datos: `kumenya_contabilidad`
--
CREATE DATABASE kumenya_contabilidad DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE kumenya_contabilidad;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `amortizaciones`
--

DROP TABLE IF EXISTS `amortizaciones`;
CREATE TABLE IF NOT EXISTS `amortizaciones` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `UidClasesBienes` bigint(16) unsigned zerofill NOT NULL,
  `FechaCompra` date NOT NULL,
  `Numero` varchar(10) NOT NULL,
  `Concepto` varchar(40) NOT NULL,
  `Origen` varchar(40) default NULL,
  `Precio` float(11,2) NOT NULL,
  `Acumulado` float(11,2) NOT NULL,
  `Anual` float(11,2) NOT NULL,
  `VNC` float(11,2) NOT NULL,
  `Activo` bit(1) NOT NULL,
  `FechaCreacion` datetime NOT NULL,
  `FechaModificacion` datetime NOT NULL,
  `FechaBaja` datetime default NULL,
  PRIMARY KEY  (`Uid`),
  KEY `FK_Objet` (`UidClasesBienes`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `apuntes`
--

DROP TABLE IF EXISTS `apuntes`;
CREATE TABLE IF NOT EXISTS `apuntes` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `UidMovimiento` bigint(16) unsigned zerofill NOT NULL,
  `Fecha` date NOT NULL,
  `Moneda` varchar(10) NOT NULL,
  `Cuenta` bigint(16) unsigned zerofill NOT NULL,
  `Concepto` varchar(100) NOT NULL,
  `Debe` float(11,2) default NULL,
  `Haber` float(11,2) default NULL,
  `Referencia` varchar(20) default NULL,
  `Activo` bit(1) NOT NULL,
  `FechaCreacion` datetime NOT NULL,
  `FechaModificacion` datetime NOT NULL,
  `FechaBaja` datetime default NULL,
  PRIMARY KEY  (`Uid`),
  KEY `FK_Movimiento` (`UidMovimiento`),
  KEY `FK_Cuenta` (`Cuenta`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1636 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `baremomesoficial`
--

DROP TABLE IF EXISTS `baremomesoficial`;
CREATE TABLE IF NOT EXISTS `baremomesoficial` (
  `Inferior` int(11) NOT NULL,
  `Superior` int(11) NOT NULL,
  `Coeficiente` varchar(4) NOT NULL,
  `Sustraendo` int(11) NOT NULL,
  PRIMARY KEY  (`Inferior`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

DROP TABLE IF EXISTS `categorias`;
CREATE TABLE IF NOT EXISTS `categorias` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Categoria` varchar(100) NOT NULL,
  `SueldoBase` float(11,2) NOT NULL,
  `Vivienda` float(11,2) NOT NULL,
  `Desplazamiento` float(11,2) NOT NULL,
  `Activo` bit(1) NOT NULL default '\0',
  `FechaCreacion` datetime NOT NULL,
  `FechaModificacion` datetime NOT NULL,
  `FechaBaja` datetime default NULL,
  PRIMARY KEY  (`Uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=78 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clases`
--

DROP TABLE IF EXISTS `clases`;
CREATE TABLE IF NOT EXISTS `clases` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `NumeroClase` int(5) NOT NULL,
  `NombreClase` varchar(100) NOT NULL,
  `TipoClase` enum('Situacion','Explotacion','Gestion') NOT NULL default 'Situacion',
  PRIMARY KEY  (`Uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clasesbienes`
--

DROP TABLE IF EXISTS `clasesbienes`;
CREATE TABLE IF NOT EXISTS `clasesbienes` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Tipo` varchar(150) NOT NULL,
  `Porcentaje` float(11,2) NOT NULL default '10.00',
  PRIMARY KEY  (`Uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=29 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clavesexternas`
--

DROP TABLE IF EXISTS `clavesexternas`;
CREATE TABLE IF NOT EXISTS `clavesexternas` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Tabla` varchar(45) NOT NULL,
  `Columna` varchar(45) NOT NULL,
  `TablaReferencia` varchar(45) NOT NULL,
  `Clave` varchar(45) NOT NULL,
  `Valor` varchar(45) NOT NULL,
  `Ambito` varchar(45) NOT NULL,
  `Buscar` enum('YES','NO') NOT NULL default 'NO',
  PRIMARY KEY  (`Uid`),
  UNIQUE KEY `UnicaClaveExterna` USING BTREE (`Tabla`,`Columna`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `condiciones`
--

DROP TABLE IF EXISTS `condiciones`;
CREATE TABLE IF NOT EXISTS `condiciones` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `UidPersona` bigint(16) unsigned zerofill NOT NULL,
  `FechaInicio` date NOT NULL,
  `FechaFin` date default NULL,
  `DiasTrabajados` int(11) NOT NULL,
  `UidCategoria` bigint(16) unsigned zerofill NOT NULL,
  `SSocial` enum('Si','No') NOT NULL default 'Si',
  `SSocialPatr` enum('Si','No') NOT NULL default 'Si',
  `SeguroMedico` enum('Si','No') NOT NULL default 'Si',
  `SeguroMedicoPatr` enum('Si','No') NOT NULL default 'Si',
  `Familia` int(11) NOT NULL default '0',
  `Activo` bit(1) NOT NULL,
  `FechaCreacion` datetime NOT NULL,
  `FechaModificacion` datetime NOT NULL,
  `FechaBaja` datetime default NULL,
  PRIMARY KEY  (`Uid`),
  KEY `fk_personas_contratos` (`UidPersona`),
  KEY `fk_categoria_contrato` (`UidCategoria`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=41 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentasbancarias`
--

DROP TABLE IF EXISTS `cuentasbancarias`;
CREATE TABLE IF NOT EXISTS `cuentasbancarias` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Cuenta` varchar(40) NOT NULL,
  `Banco` varchar(40) NOT NULL,
  `UidTercero` bigint(16) NOT NULL,
  `TipoTercero` enum('Persona','Organizacion') NOT NULL,
  `Activo` bit(1) NOT NULL,
  `FechaCreacion` datetime NOT NULL,
  `FechaModificacion` datetime NOT NULL,
  `FechaBaja` datetime default NULL,
  PRIMARY KEY  (`Uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentascontables`
--

DROP TABLE IF EXISTS `cuentascontables`;
CREATE TABLE IF NOT EXISTS `cuentascontables` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `UidClase` bigint(16) unsigned zerofill NOT NULL,
  `UidTercero` bigint(16) unsigned zerofill default NULL,
  `TipoCuenta` enum('Activo','Pasivo','Ingresos','Gastos','Gestion') NOT NULL,
  `NumeroCuenta` varchar(10) NOT NULL,
  `NombreCuenta` varchar(100) NOT NULL,
  `Debe` float(11,2) NOT NULL,
  `Haber` float(11,2) NOT NULL,
  `Padre` bigint(16) unsigned zerofill default NULL,
  `TipoTercero` enum('Persona','Organizacion','Ninguno') NOT NULL,
  `Activo` bit(1) NOT NULL,
  `FechaCreacion` datetime NOT NULL,
  `FechaModificacion` datetime NOT NULL,
  `FechaBaja` datetime default NULL,
  PRIMARY KEY  (`Uid`),
  KEY `FK_Padre` (`Padre`),
  KEY `FK_Clase` (`UidClase`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1176 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventualidades`
--

DROP TABLE IF EXISTS `eventualidades`;
CREATE TABLE IF NOT EXISTS `eventualidades` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `UidPersona` bigint(16) unsigned zerofill NOT NULL,
  `Concepto` varchar(100) NOT NULL,
  `Porcentual` bit(1) NOT NULL,
  `Importe` float(11,2) NOT NULL,
  `Limite` float default NULL,
  `Aplicado` enum('Bruto','Neto') NOT NULL default 'Bruto',
  `IPR` bit(1) NOT NULL,
  `Tipo` enum('Descuento','Abono') NOT NULL default 'Abono',
  `FechaInicio` date NOT NULL,
  `FechaFin` date default NULL,
  `Activo` bit(1) NOT NULL default '',
  `FechaCreacion` datetime NOT NULL,
  `FechaModificacion` datetime NOT NULL,
  `FechaBaja` datetime default NULL,
  PRIMARY KEY  (`Uid`),
  KEY `FK_persona` (`UidPersona`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos`
--

DROP TABLE IF EXISTS `movimientos`;
CREATE TABLE IF NOT EXISTS `movimientos` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Numero` varchar(11) NOT NULL,
  `Borrador` enum('Si','No') NOT NULL,
  `TotalDebe` float(11,2) default '0.00',
  `TotalHaber` float(11,2) default '0.00',
  `Activo` bit(1) NOT NULL,
  `FechaCreacion` datetime NOT NULL,
  `FechaModificacion` datetime NOT NULL,
  `FechaBaja` datetime default NULL,
  PRIMARY KEY  (`Uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=527 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nominas`
--

DROP TABLE IF EXISTS `nominas`;
CREATE TABLE IF NOT EXISTS `nominas` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `UidPersona` bigint(16) unsigned zerofill NOT NULL,
  `SueldoBase` int(11) NOT NULL,
  `AyudaVivienda` int(11) NOT NULL,
  `AyudaDesplazamiento` int(11) NOT NULL,
  `EvAbonoBruto` int(11) NOT NULL,
  `EvDescuentoBruto` int(11) NOT NULL,
  `SueldoBruto` int(11) NOT NULL,
  `AyudaFamilia` int(11) NOT NULL,
  `SeguridadSocialEmpleado` int(11) NOT NULL,
  `MutualidadEmpleado` int(11) NOT NULL,
  `SeguridadSocialPatron` int(11) NOT NULL,
  `MutualidadPatron` int(11) NOT NULL,
  `IPR` int(11) NOT NULL,
  `R` int(11) NOT NULL,
  `ImpuestoBruto` int(11) NOT NULL,
  `ImpuestoNeto` int(11) NOT NULL,
  `EvAbonoNeto` int(11) NOT NULL,
  `EvDescuentoNeto` int(11) NOT NULL,
  `SalarioNeto` int(11) NOT NULL,
  `DiasTrabajados` int(5) NOT NULL,
  `FechaEmision` date NOT NULL,
  `Contrato` enum('Si','No') NOT NULL default 'No',
  PRIMARY KEY  (`Uid`),
  KEY `fk_personas` (`UidPersona`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=282 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `organizaciones`
--

DROP TABLE IF EXISTS `organizaciones`;
CREATE TABLE IF NOT EXISTS `organizaciones` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Nombre` varchar(50) NOT NULL COMMENT 'Prueba para la contabilidad',
  `Apellidos` varchar(50) default NULL,
  `NumIdentificacion` varchar(20) NOT NULL,
  `Direccion` varchar(200) NOT NULL,
  `Distrito` varchar(100) default NULL,
  `Localidad` bigint(16) unsigned zerofill NOT NULL default '0000000000000001',
  `Provincia` bigint(16) unsigned zerofill NOT NULL,
  `Pais` bigint(16) unsigned zerofill NOT NULL,
  `Activo` bit(1) NOT NULL default '',
  `FechaCreacion` datetime NOT NULL,
  `FechaModificacion` datetime NOT NULL,
  `FechaBaja` datetime default NULL,
  PRIMARY KEY  (`Uid`),
  KEY `FK_Localidad` (`Localidad`),
  KEY `FK_Pais` (`Pais`),
  KEY `FK_Provincia` (`Provincia`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parametros`
--

DROP TABLE IF EXISTS `parametros`;
CREATE TABLE IF NOT EXISTS `parametros` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Nombre` varchar(100) NOT NULL,
  `Orden` int(10) unsigned NOT NULL,
  `UidProc` bigint(16) unsigned NOT NULL,
  `Tipo` enum('IN','OUT','INOUT') NOT NULL,
  `TipoDatos` varchar(100) default NULL,
  `ConsultaQuery` varchar(500) default NULL,
  PRIMARY KEY  (`Uid`),
  UNIQUE KEY `ParametroUnico` (`Nombre`,`UidProc`),
  UNIQUE KEY `OrdenUnico` USING BTREE (`Orden`,`UidProc`),
  KEY `FK_parametros_procedimientos` (`UidProc`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1273 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `procedimientos`
--

DROP TABLE IF EXISTS `procedimientos`;
CREATE TABLE IF NOT EXISTS `procedimientos` (
  `Uid` bigint(16) unsigned zerofill NOT NULL auto_increment,
  `Nombre` varchar(100) NOT NULL,
  PRIMARY KEY  (`Uid`),
  UNIQUE KEY `NombreUnico` (`Nombre`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=291 ;

--
-- Filtros para las tablas descargadas (dump)
--

--
-- Filtros para la tabla `amortizaciones`
--
ALTER TABLE `amortizaciones`
  ADD CONSTRAINT `amortizaciones_ibfk_1` FOREIGN KEY (`UidClasesBienes`) REFERENCES `clasesbienes` (`Uid`);

--
-- Filtros para la tabla `apuntes`
--
ALTER TABLE `apuntes`
  ADD CONSTRAINT `FK_Cuenta` FOREIGN KEY (`Cuenta`) REFERENCES `cuentascontables` (`Uid`),
  ADD CONSTRAINT `FK_Movimiento` FOREIGN KEY (`UidMovimiento`) REFERENCES `movimientos` (`Uid`);

--
-- Filtros para la tabla `condiciones`
--
ALTER TABLE `condiciones`
  ADD CONSTRAINT `fk_categoria_contrato` FOREIGN KEY (`UidCategoria`) REFERENCES `categorias` (`Uid`),
  ADD CONSTRAINT `fk_personas_contratos` FOREIGN KEY (`UidPersona`) REFERENCES `kumenya_matriculacion`.`personas` (`Uid`);

--
-- Filtros para la tabla `cuentascontables`
--
ALTER TABLE `cuentascontables`
  ADD CONSTRAINT `FK_Clase` FOREIGN KEY (`UidClase`) REFERENCES `clases` (`Uid`),
  ADD CONSTRAINT `FK_Padre` FOREIGN KEY (`Padre`) REFERENCES `cuentascontables` (`Uid`);

--
-- Filtros para la tabla `eventualidades`
--
ALTER TABLE `eventualidades`
  ADD CONSTRAINT `FK_persona` FOREIGN KEY (`UidPersona`) REFERENCES `kumenya_matriculacion`.`personas` (`Uid`);

--
-- Filtros para la tabla `nominas`
--
ALTER TABLE `nominas`
  ADD CONSTRAINT `fk_personas` FOREIGN KEY (`UidPersona`) REFERENCES `kumenya_matriculacion`.`personas` (`Uid`);

--
-- Filtros para la tabla `organizaciones`
--
ALTER TABLE `organizaciones`
  ADD CONSTRAINT `FK_Localidad` FOREIGN KEY (`Localidad`) REFERENCES `kumenya_matriculacion`.`localidades` (`Uid`),
  ADD CONSTRAINT `FK_Pais` FOREIGN KEY (`Pais`) REFERENCES `kumenya_matriculacion`.`paises` (`Uid`),
  ADD CONSTRAINT `FK_Provincia` FOREIGN KEY (`Provincia`) REFERENCES `kumenya_matriculacion`.`provincias` (`Uid`);

--
-- Filtros para la tabla `parametros`
--
ALTER TABLE `parametros`
  ADD CONSTRAINT `FK_parametros_procedimientos` FOREIGN KEY (`UidProc`) REFERENCES `procedimientos` (`Uid`);

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `AltaDeAmortizacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeAmortizacion`(UidBienes bigint(16), FCompra date, Num varchar(10), Concept varchar(40), Orig varchar(40), Price float(11), OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	set @exito = 0;
	if (select count(*) from amortizaciones where Numero = Num) > 0 then
		set @salida = 'El numero de amortización ya está dado de alta';
	else
		if concat(FCompra, Num, Concept, Price) is null then
			set @exito = 0;
			set @salida = 'Campos obligatorios vacíos';
		else
			insert into amortizaciones
				(UidClasesBienes, FechaCompra, Numero, Concepto, Origen, Precio, Acumulado, Anual, VNC, Activo, FechaCreacion, FechaModificacion)
			values
				(UidBienes, FCompra, Num, Concept, Orig, Price, 0, 0, 0, 1, now(), now());
			set @salida = 'Se ha creado el registro';
			set @exito = 1;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `AltaDeApunte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeApunte`(idmov bigint(16), fech varchar(10), mone varchar(10), idcuen bigint(16), conc varchar(100), deb float, hab float, doc varchar(20), out exito int(11), out salida varchar(50))
begin
	START TRANSACTION;
	if (concat(idmov, fech, mone, idcuen, conc) is null) or (deb is null and hab is null) then
		set @exito = 0;
		set @salida = 'Campos obligatorios vacíos';
	else
		if deb is null then
			set deb = 0;
		end if;
		if hab is null then
			set hab = 0;
		end if;
		set @tothmov = (select TotalHaber from movimientos where Uid = idmov);
		set @totdmov = (select TotalDebe from movimientos where Uid = idmov);
		set @tothcu = (select Debe from cuentascontables where Uid = idcuen);
		set @totdcu = (select Haber from cuentascontables where Uid = idcuen);
		insert into apuntes (UidMovimiento, Fecha, Moneda, Cuenta, Concepto, Debe, Haber, Referencia, Activo, FechaCreacion, FechaModificacion)
		values (idmov, fech, mone, idcuen, conc, deb, hab, doc, 1, now(), now());
		update movimientos set
			TotalDebe = @totdmov + deb,
			TotalHaber = @tothmov + hab
		where Uid = idmov;
		update cuentascontables set
			Debe = @totdcu + deb,
			Haber = @tothcu + hab
		where Uid = idcuen;
		set @exito = 1;
		set @salida = 'Apunte insertado';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `AltaDeCategorias`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeCategorias`(Categ varchar(100), SBase float, AVivienda float, ADesplazamiento float, out exito int(11), out salida varchar(200))
BEGIN
	START TRANSACTION;
	if concat(Categ, SBase, Avivienda, ADesplazamiento) is null then
		set @exito = 0;
		set @salida ='Todos los campos son obligatorios';
	else
		insert into categorias (Categoria, SueldoBase, Vivienda, Desplazamiento, Activo, FechaCreacion, FechaModificacion)
		values (Categ, SBase, AVivienda, ADesplazamiento, 1, now(), now());
		set @exito = 1;
		set @salida = 'Se ha creado el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `AltaDeClase`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeClase`(nume varchar(5), nomb varchar(100), tipo enum('Situacion','Explotacion','Otras'), out exito int(11), out salida varchar(50))
begin
	START TRANSACTION;
	if isnull(concat(nume, nomb)) then
		set @exito = 0;
		set @salida = 'Campos obligatorios vacíos';
	else
		if (select count(*) from clases where NumeroClase = nume) > 0 then
			set @exito = 0;
			set @salida = 'La clase ya existe';
		else
			if (cast(nume as unsigned)) then
				insert into clases (NumeroClase, NombreClase, TipoClase) values (nume, nomb, tipo);
				set @exito = 1;
				set @salida = 'Se ha creado el registro';
			else
				set @exito = 0;
				set @salida = 'Valor no válido';
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `AltaDeClaseBien`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeClaseBien`(obj varchar(100), porcen float, out exito int(11), out salida varchar(50))
begin
	START TRANSACTION;
	if concat(obj, porcen) is not null then
		if (select count(*) from clasesbienes where Tipo = obj) = 0 then
			insert into clasesbienes (Tipo,Porcentaje) value (obj, porcen);
			set @exito = 1;
			set @salida = 'Se ha creado el registro';
		else
			set @exito = 0;
			set @salida = 'Ya existe el registro';
		end if;
	else
		set @exito = 0;
		set @salida = 'Campos obligatorios vacíos';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `AltaDeCondicion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeCondicion`(UidPer bigint(16), Fechini varchar(10), Fechfin varchar(10), UidCat bigint(16), ssocem enum('Si','No'), ssocpa enum('Si','No'), segmedem enum('Si','No'), segmedpa enum('Si','No'), fam int(11), diastrab int(11), out exito int(11), out salida varchar(100))
begin
	START TRANSACTION;
	if concat(UidPer, Fechini, UidCat, ssocem, segmedem, ssocpa, segmedpa, diastrab) is null then
		set @exito = 0;
		set @salida ='Campos obligatorios vacíos';
	else
		if (select count(*) from categorias where Uid = UidCat and Activo = 1) = 0 then
			set @exito = 0;
			set @salida = 'No existe la categoría';
		else
			if (Fechfin is null) then
				set Fechfin = str_to_date(concat(year(date),'-12-31'),'%Y-%m-%d');
			end if;
			if (Fechfin < Fechini) then
				set @exito = 0;
				set @salida = 'La fecha de fin no puede ser anterior a la fecha de inicio';
			else
				set @exito = 1;
			end if;
		end if;
	end if;
	if @exito = 1 then
		insert into condiciones (UidPersona, FechaInicio, FechaFin, DiasTrabajados, UidCategoria, SSocial, SSocialPatr, SeguroMedico, SeguroMedicoPatr, Familia, Activo, FechaCreacion, FechaModificacion)
		values (UidPer, Fechini, Fechfin, diastrab, UidCat, ssocem, ssocpa, segmedem, segmedpa, fam, 1, now(), now());
		set @salida = 'Se ha creado el registro';
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;

end$$

DROP PROCEDURE IF EXISTS `AltaDeCuentaBancaria`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeCuentaBancaria`(cuen varchar(40), ban varchar(40), Id bigint(16), tip enum('Persona','Organizacion'), out exito int(11), out salida varchar(50))
begin
	START TRANSACTION;
	if isnull(concat(cuen, ban)) then
		set @exito = 0;
		set @salida = 'Campos obligatorios vacíos';
	else
		if (select count(*) from cuentasbancarias where Cuenta = cuen and Activo = 1) > 0 then
			set @exito = 0;
			set @salida = 'La cuenta bancaria ya existe';
		else
			if (select count(*) from cuentasbancarias where Activo = 1 and UidTercero = Id and TipoTercero = tip) > 0 then
				set @exito = 0;
				set @salida = 'Ya existe una cuenta bancaria para este tercero';
			else
				insert into cuentasbancarias (Cuenta, Banco, UidTercero, TipoTercero, Activo, FechaCreacion, FechaModificacion) values (cuen, ban, Id, tip, 1, now(), now());
				set @exito = 1;
				set @salida = 'Se ha creado el registro';
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `AltaDeCuentaContable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeCuentaContable`(clase bigint(16), IdTercero bigint(16), numcuen varchar(10), nomcuenta varchar(100), IdPadre bigint(16), tiptercero enum('Persona','Organizacion','Ninguno'), tipcuen enum ('Activo','Pasivo','Ingresos','Gastos','Gestion'), out exito int(11), out salida varchar(100))
begin
	START TRANSACTION;
	if isnull(concat(clase, numcuen,nomcuenta,tiptercero)) or (tiptercero <> "Ninguno" and isnull(IdTercero)) then
		set @exito = 0;
		set @salida = 'Campos obligatorios vacíos';
	else
		if not isnull(IdPadre) then
			if ((select count(*) from cuentascontables where Uid = IdPadre) = 0)  then
				set @exito = 0;
				set @salida = 'La cuenta padre no existe';
			else
				set @numpap = (select NumeroCuenta from cuentascontables where Uid = IdPadre);
				set @numpuntos = NumeroPuntos(numcuen);
				set @pap = substring_index(numcuen,'.',@numpuntos);
				if (@pap <> @numpap) then
					set @exito = 0;
					set @salida = 'La cuenta padre no es correcta';
				else
					set @exito = 1;
				end if;
			end if;
		else
			set @numpuntos = NumeroPuntos(numcuen);
			if (@numpuntos > 0) then
				set @exito = 0;
				set @salida = 'Tiene que elegir la cuenta padre';
			else
				set @exito = 1;
			end if;
		end if;
		if @exito = 1 then
			set @numclase = (select NumeroClase from clases where Uid = clase);
			if (@numclase <> mid(numcuen,1,1)) then
				set @exito = 0;
				set @salida = 'La cuenta no corresponde a la clase';
			else
				if (select count(*) from cuentascontables where NumeroCuenta = numcuen) > 0 then
					set @exito = 0;
					set @salida = 'La cuenta contable ya existe';
				else
					if (tiptercero = 'Persona') then
						set @exito = 0;
						set @salida = 'No puede dar de alta una cuenta contable de una persona';
					else
						insert into cuentascontables (UidClase, UidTercero, TipoCuenta, NumeroCuenta, NombreCuenta, Debe, Haber, Padre, TipoTercero, Activo, FechaCreacion, FechaModificacion)
						values (clase, IdTercero, tipcuen, numcuen, nomcuenta, 0, 0, IdPadre, tiptercero, 1, now(), now());
						set @salida = 'Se ha creado el registro';
					end if;
				end if;
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `AltaDeEventualidad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeEventualidad`(UidPer bigint(16), Concept varchar(100), Import float, Aplic enum('Bruto','Neto'), Tip enum('Abono','Descuento'), Fechini varchar(10), Fechfin varchar(10), out exito int(11), out salida varchar(200))
BEGIN
	START TRANSACTION;
	if concat(UidPer, Concept, Import, Aplic, Tip, Fechini) is null then
		set @exito = 0;
		set @salida ='Campos obligatorios vacíos';
	else
		if (Fechfin is null) then
			set Fechfin = str_to_date(concat(year(date),'-12-31'),'%Y-%m-%d');
		end if;
		if (Fechfin < Fechini) then
			set @exito = 0;
			set @salida = 'La fecha de fin no puede ser anterior a la fecha de inicio';
		else
			set @exito = 1;
		end if;
	end if;
	if @exito = 1 then
		insert into eventualidades (UidPersona, Concepto, Porcentual, Importe, Limite, Aplicado, IPR, Tipo, FechaInicio, FechaFin, Activo, FechaCreacion, FechaModificacion)
		values (UidPer, Concept, 0, abs(Import), 0, Aplic, 0, Tip, Fechini, Fechfin, 1, now(), now());
		set @salida = 'Se ha creado el registro';
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `AltaDeMovimiento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeMovimiento`(nume varchar(11), borr enum('Si','No'), out exito int(11), out salida varchar(50), out iden bigint(16))
begin

	START TRANSACTION;
	set @iden = 0;
	if nume is null then
		set @exito = 0;
		set @salida = 'Campos obligatorios vacíos';
	else
		if (select nume in (select Numero from movimientos where Activo = 1)) then
			set @exito = 0;
			set @salida = 'El número de movimiento ya existe';
		else
			insert into movimientos (Numero, Borrador, TotalDebe, TotalHaber, Activo, FechaCreacion, FechaModificacion)
			values (nume, borr, 0, 0, 1, now(), now());
			set @iden = last_insert_id();
			set @exito = 1;
			set @salida = 'Movimiento activo';
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida,@iden;

end$$

DROP PROCEDURE IF EXISTS `AltaDeOrganizacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeOrganizacion`(Nombr varchar(50), Apellid varchar(50), NumId varchar(20), Dir varchar(200), Distr varchar(100), Loca int, Prov int, Pai int, OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	if isnull(concat(Nombr,NumId, Dir, Loca,Prov, Pai))=1 then
		set @exito = 0;
		set @salida = ValidarNullAltaOrganizacion(Nombr, NumId, Dir, Loca, Prov, Pai);
	else
		if  (select count(*) from organizaciones where  NumIdentificacion= NumId) > 0 then
			set @salida = 'Número de identificación ya existente';
			set @exito = 0;
		else
			insert into organizaciones
				(Nombre, Apellidos, NumIdentificacion, Direccion, Distrito, Localidad, Provincia, Pais, Activo, FechaCreacion, FechaModificacion)
			values
				(Nombr, Apellid, NumId, Dir, Distr, Loca, Prov, Pai, 1, now(), now());
			set @salida = 'Se ha creado el registro';
			set @exito = 1;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `AltaDePagaMensual`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDePagaMensual`(Id bigint(16), sbase float, sbruto float, abon float, descu float, mes date, out exito int(11), out salida varchar(50))
begin
	START TRANSACTION;
	if concat(sbase, sbruto) is null then
		set @exito = 0;
		set @salida = 'Campos obligatorios vacíos';
	else
		if abon is null then
			set abon = 0;
		end if;
		if descu is null then
			set descu = 0;
		end if;
		set @salnet = sbruto + abon - descu;
		insert into nominas (UidPersona, SueldoBase, AyudaVivienda, AyudaDesplazamiento, EvAbonoBruto, EvDescuentoBruto, SueldoBruto, AyudaFamilia, SeguridadSocialEmpleado, MutualidadEmpleado, SeguridadSocialPatron, MutualidadPatron,
						IPR, R, ImpuestoBruto, ImpuestoNeto, EvAbonoNeto, EvDescuentoNeto, SalarioNeto, DiasTrabajados, FechaEmision, Contrato)
		values (Id, sbase, 0, 0, abon, descu, sbruto, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @salnet, 30, mes, 'No');
		set @exito = 1;
		set @salida = 'Se ha creado el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `AltaDeTipoMovimiento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeTipoMovimiento`(mov varchar(100), out exito int(11), out salida varchar(100))
begin
	START TRANSACTION;
	if isnull(mov) then
		set @exito = 0;
		set @salida = 'Campo obligatorio vacío';
	else
		if (select count(*) from tiposmovimientos where Movimiento = mov) > 0 then
			set @exito = 0;
			set @salida = 'El tipo de movimiento ya existe';
		else
			insert into tiposmovimientos (Movimiento) values (mov);
			set @exito = 1;
			set @salida = 'Se ha creado el registro';
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `AltaDeUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaDeUsuario`(usuar varchar(45), pass varchar(45), person bigint(16), tipousuar enum ('Contable','Administrativo','TEDECO','Profesor','Decano','Bibliotecario'), out exito int(11), out salida varchar(100))
BEGIN
	START TRANSACTION;
	if (usuar is null) or (pass is null) or (person is null) or (tipousuar is null) then
		set @exito = 0;
		set @salida = ValidarNullAltaUsuario (usuar, pass, person, tipousuar);
	else
		set @per = (select Uid from kumenya_matriculacion.personas where Uid = person and Activo = 1);
		if (@per is null) then
			set @salida = 'No existe la persona seleccionada';
			set @exito = 0;
		else
			if (select count(*) from usuarios where Usuario = usuar and TipoUsuario = tipousuar and Activo = 1) > 0 then
				set @salida = 'Ya existe el usuario y el rol seleccionados';
				set @exito = 0;
			else
				insert into usuarios (Usuario, Contrasena, Persona, TipoUsuario, Activo, FechaCreacion, FechaModificacion) values (usuar, pass, person, tipousuar, 1, now(), now());
				set @exito = 1;
				set @salida = 'Se ha creado el registro';
			end if;
		end if;
	end if;
	if (@exito = 0) then
		ROLLBACK;
	else
		COMMIT;
	end if;
	select @exito, @salida;
END$$

DROP PROCEDURE IF EXISTS `Amortizacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Amortizacion`(UidAmor bigint(16), OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	set @exito = 0;
	set @acumulado = (select Acumulado from amortizaciones where Uid=UidAmor);
	set @price = (select Precio from amortizaciones where Uid = UidAmor);
	set @clasesbienes = (select UidClasesBienes from amortizaciones where Uid = UidAmor);
	set @num = (select UidClasesBienes from amortizaciones where Uid = UidAmor);
	set @inicio = (select month(Valor) from kumenya_biblioteca.configuracion where NombreAtributo = 'FechaCierreContable');
	set @mescompra = (select month(FechaCompra) from amortizaciones where Uid=UidAmor) ;
	if  @inicio >= @mescompra then
		set @meses = @inicio - @mescompra + 1;
	else
		set @meses = @inicio + 12 - @mescompra;
	end if;
	if @acumulado <> 0 then
		set @meses = 12;
	end if;
	set @anual = (@price * (select Porcentaje from clasesbienes where Uid = @clasesbienes) * @meses) / (100 * 12);
	set @VN = @price - @anual;
	set @vnc = (select acumulado from amortizaciones where Uid=UidAmor) + @anual;
	if @price < @vnc then
		set @vnc = @price;
	end if;
	update amortizaciones set
		Acumulado = Acumulado + @anual,
		Anual = @anual,
		VNC = @price - @vnc,
		FechaModificacion = now()
	where Uid = UidAmor and Activo = 1;
	if (select count(*) from amortizaciones where Uid=UidAmor and Activo = 1) = 0 then
		set @salida = 'No existe este objeto en la amortización';
	else
		set @exito = 1;
		set @salida = 'Amortización realizada';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `ApuntesNomina`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ApuntesNomina`(fechaent varchar(10), out exito int(11), out salida varchar(10))
begin
	START TRANSACTION;

	set @literal = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'ApunteINSSEmpleado');
	if (select count(*) from apuntes where Concepto = @literal and month(Fecha) =month(fechaent) and year(Fecha) = year(fechaent)) = 1 then

		set @exito = 0;
		set @salida = 'Apuntes ya generados';
	else
		set @sbruto = (select sum(SueldoBruto) from nominas where month(FechaEmision) = month(fechaent) and year(FechaEmision) = year(fechaent) and Contrato = 'Si');
		set @segsocemp = (select sum(SeguridadSocialEmpleado) from nominas where month(FechaEmision) = month(fechaent)  and year(FechaEmision) = year(fechaent) and Contrato = 'Si');
		set @segsocpat = (select sum(SeguridadSocialPatron) from nominas where month(FechaEmision) = month(fechaent)  and year(FechaEmision) = year(fechaent) and Contrato = 'Si');
		set @mutemp = (select sum(MutualidadEmpleado) from nominas where month(FechaEmision) = month(fechaent)  and year(FechaEmision) = year(fechaent) and Contrato = 'Si');
		set @mutpat = (select sum(MutualidadPatron) from nominas where month(FechaEmision) = month(fechaent)  and year(FechaEmision) = year(fechaent) and Contrato = 'Si');
		set @totimpn = (select sum(ImpuestoNeto) from nominas where month(FechaEmision) = month(fechaent)  and year(FechaEmision) = year(fechaent) and Contrato = 'Si');
		set @descneto = (select sum(EvDescuentoNeto) from nominas where month(FechaEmision) = month(fechaent)  and year(FechaEmision) = year(fechaent) and Contrato = 'Si');
		set @aboneto = (select sum(EvAbonoNeto) from nominas where month(FechaEmision) = month(fechaent) and year(FechaEmision) = year(fechaent) and Contrato = 'Si');
		set @sneto = (select sum(SalarioNeto) from nominas where month(FechaEmision) = month(fechaent)  and year(FechaEmision) = year(fechaent) and Contrato = 'Si');
		set @fechem = (select distinct FechaEmision from nominas where month(FechaEmision) = month(fechaent)  and year(FechaEmision) = year(fechaent) and Contrato = 'Si');

		set @num = mid((select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'MovimientosAutomaticos'), 2) + 1;
		update kumenya_biblioteca.configuracion set
			Valor = concat( 'K', @num)
		where NombreAtributo = 'MovimientosAutomaticos';
		insert into movimientos (Numero, Borrador, TotalDebe, TotalHaber, Activo, FechaCreacion, FechaModificacion)
		values (concat('K',@num), 'No', 0, 0, 1, now(), now());
		set @ulti = LAST_INSERT_ID();

		if @segsocemp <> 0 then
			set @literal = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'ApunteINSSEmpleado');
			insert into apuntes (UidMovimiento, Fecha, Moneda, Cuenta, Concepto, Debe, Haber, Referencia, Activo, FechaCreacion, FechaModificacion)
			values (@ulti, @fechem, 'FBU', (select Uid from cuentascontables where NumeroCuenta = '45.1'), @literal, 0, @segsocemp, null, 1, now(), now());

			update cuentascontables set Haber = Haber + @segsocemp where NumeroCuenta = '45.1';
		end if;

		if @segsocpat <> 0 then
			set @literal = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'ApunteINSSPatronal');
			insert into apuntes (UidMovimiento, Fecha, Moneda, Cuenta, Concepto, Debe, Haber, Referencia, Activo, FechaCreacion, FechaModificacion)
			values (@ulti, @fechem, 'FBU', (select Uid from cuentascontables where NumeroCuenta = '65.2'), @literal, @segsocpat, 0, null, 1, now(), now());

			update cuentascontables set Debe = Debe + @segsocpat where NumeroCuenta = '65.2';

			insert into apuntes (UidMovimiento, Fecha, Moneda, Cuenta, Concepto, Debe, Haber, Referencia, Activo, FechaCreacion, FechaModificacion)
			values (@ulti, @fechem, 'FBU', (select Uid from cuentascontables where NumeroCuenta = '45.1'), @literal, 0, @segsocpat, null, 1, now(), now());

			update cuentascontables set Haber = Haber + @segsocpat where NumeroCuenta = '45.1';
		end if;

		if @mutemp <> 0 then
			set @literal = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'ApunteMutuaEmpleado');
			insert into apuntes (UidMovimiento, Fecha, Moneda, Cuenta, Concepto, Debe, Haber, Referencia, Activo, FechaCreacion, FechaModificacion)
			values (@ulti, @fechem, 'FBU', (select Uid from cuentascontables where NumeroCuenta = '45.2'), @literal, 0, @mutemp, null, 1, now(), now());

			update cuentascontables set Haber = Haber + @mutemp where NumeroCuenta = '45.2';
		end if;

		if @mutpat <> 0 then
			set @literal = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'ApunteMutuaPatronal');
			insert into apuntes (UidMovimiento, Fecha, Moneda, Cuenta, Concepto, Debe, Haber, Referencia, Activo, FechaCreacion, FechaModificacion)
			values (@ulti, @fechem, 'FBU', (select Uid from cuentascontables where NumeroCuenta = '65.4'), 'Mutuelle patronale', @mutpat, 0, null, 1, now(), now());

			update cuentascontables set Debe = Debe + @mutpat where NumeroCuenta = '65.4';
			insert into apuntes (UidMovimiento, Fecha, Moneda, Cuenta, Concepto, Debe, Haber, Referencia, Activo, FechaCreacion, FechaModificacion)
			values (@ulti, @fechem, 'FBU', (select Uid from cuentascontables where NumeroCuenta = '45.2'), @literal, 0, @mutpat, null, 1, now(), now());

			update cuentascontables set Haber = Haber + @mutpat where NumeroCuenta = '45.2';
		end if;

		if @sbruto <> 0 then
			set @literal = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'ApunteSalarioBruto');
			insert into apuntes (UidMovimiento, Fecha, Moneda, Cuenta, Concepto, Debe, Haber, Referencia, Activo, FechaCreacion, FechaModificacion)
			values (@ulti, @fechem, 'FBU', (select Uid from cuentascontables where NumeroCuenta = '65.1'), @literal, @sbruto, 0, null, 1, now(), now());

			update cuentascontables set Debe = Debe + @sbruto where NumeroCuenta = '65.1';
		end if;

		if @totimpn <> 0 then
			set @literal = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'ApunteImpuestoNeto');
			insert into apuntes (UidMovimiento, Fecha, Moneda, Cuenta, Concepto, Debe, Haber, Referencia, Activo, FechaCreacion, FechaModificacion)
			values (@ulti, @fechem, 'FBU', (select Uid from cuentascontables where NumeroCuenta = '43.1'), @literal, 0, @totimpn, null, 1, now(), now());

			update cuentascontables set Haber = Haber + @totimpn where NumeroCuenta = '43.1';
		end if;

		if @descneto <> 0 then
			set @literal = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'ApunteOtrasRetenciones');
			insert into apuntes (UidMovimiento, Fecha, Moneda, Cuenta, Concepto, Debe, Haber, Referencia, Activo, FechaCreacion, FechaModificacion)
			values (@ulti, @fechem, 'FBU', (select Uid from cuentascontables where NumeroCuenta = '43.9'), @literal, 0, @descneto, null, 1, now(), now());

			update cuentascontables set Haber = Haber + @descneto where NumeroCuenta = '43.9';
		end if;

		if @aboneto <> 0 then
			set @literal = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'ApunteOtrosAbonos');
			insert into apuntes (UidMovimiento, Fecha, Moneda, Cuenta, Concepto, Debe, Haber, Referencia, Activo, FechaCreacion, FechaModificacion)
			select @ulti, @fechem, 'FBU', cuentascontables.Uid as cuentacontable, @literal, 0, @aboneto , null, 1, now(), now()
			from cuentascontables, nominas, kumenya_matriculacion.personas
			where cuentascontables.UidTercero = kumenya_matriculacion.personas.Uid and nominas.UidPersona = kumenya_matriculacion.personas.Uid and
			cuentascontables.UidTercero = nominas.UidPersona and month(FechaEmision) = month(fechaent) and year(FechaEmision) = year(fechaent) and Contrato = 'Si' and cuentascontables.TipoTercero='Persona';

			update cuentascontables, nominas, kumenya_matriculacion.personas set cuentascontables.Haber = cuentascontables.Haber + @aboneto
			where cuentascontables.UidTercero = kumenya_matriculacion.personas.Uid and nominas.UidPersona = kumenya_matriculacion.personas.Uid and
			cuentascontables.UidTercero = nominas.UidPersona and month(nominas.FechaEmision) = month(fechaent) and year(nominas.FechaEmision) = year(fechaent) and nominas.Contrato = 'Si' and cuentascontables.TipoTercero='Persona';
		end if;
		set @literal = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'ApunteSalarioNeto');
		insert into apuntes (UidMovimiento, Fecha, Moneda, Cuenta, Concepto, Debe, Haber, Referencia, Activo, FechaCreacion, FechaModificacion)
		select @ulti, @fechem, 'FBU', cuentascontables.Uid as cuentacontable, @literal, 0, nominas.SalarioNeto , null, 1, now(), now()
		from cuentascontables, nominas, kumenya_matriculacion.personas
		where cuentascontables.UidTercero = kumenya_matriculacion.personas.Uid and nominas.UidPersona = kumenya_matriculacion.personas.Uid and
		cuentascontables.UidTercero = nominas.UidPersona and month(FechaEmision) = month(fechaent) and year(FechaEmision) = year(fechaent) and Contrato = 'Si' and cuentascontables.TipoTercero='Persona';

		update cuentascontables, nominas, kumenya_matriculacion.personas set cuentascontables.Haber = cuentascontables.Haber + nominas.SalarioNeto
		where cuentascontables.UidTercero = kumenya_matriculacion.personas.Uid and nominas.UidPersona = kumenya_matriculacion.personas.Uid and
		cuentascontables.UidTercero = nominas.UidPersona and month(nominas.FechaEmision) = month(fechaent) and year(nominas.FechaEmision) = year(fechaent) and nominas.Contrato = 'Si' and cuentascontables.TipoTercero='Persona';

		update movimientos set
			TotalDebe = (select sum(Debe) from apuntes where UidMovimiento = @ulti),
			TotalHaber = (select sum(Haber) from apuntes where UidMovimiento = @ulti)
		where Uid = @ulti;

		set @exito = 1;
		set @salida = 'Apuntes realizados';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `BajaDeAmortizacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeAmortizacion`(UidAmort bigint(16), OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	set @exito = 0;
	if (select count(*) from amortizaciones where Uid = UidAmort) = 0 then
		set @salida = 'No existe este objeto en la amortización';
	else
		delete from amortizaciones where Uid = UidAmort;
		set @salida = 'Se ha dado de baja el registro';
		set @exito = 1;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `BajaDeCategorias`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeCategorias`(Id bigint(16), out exito int(11), out salida varchar(200))
BEGIN
	START TRANSACTION;
	if (select count(*) from categorias where Uid= Id) = 0 then
		set @exito = 0;
		set @salida = 'No existe el registro';
	else
		update categorias set Activo= 0, FechaBaja=now() where Uid= Id;
		set @exito = 1;
		set @salida = 'Se ha dado de baja el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `BajaDeClase`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeClase`(Id bigint(16), out exito int(11), out salida varchar(50))
begin
	START TRANSACTION;
	if (select count(*) from clases where Uid = Id) = 0 then
		set @exito = 0;
		set @salida = 'No existe el registro';
	else
		if (select count(*) from cuentascontables where UidClase = Id) > 0 then
			set @exito = 0;
			set @salida = 'Hay cuentas contables asociadas a esta clase. No se puede borrar';
		else
			delete from clases where Uid = Id;
			set @exito = 1;
			set @salida = 'Se ha dado de baja el registro';
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `BajaDeCondicion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeCondicion`(Id bigint(16), out exito int(11), out salida varchar(50))
begin
	START TRANSACTION;
	if (select count(*) from condiciones where Uid= Id) = 0 then
		set @exito = 0;
		set @salida = 'No existe el registro';
	else
		update condiciones set Activo= 0, FechaBaja=now() where Uid= Id;
		set @exito = 1;
		set @salida = 'Se ha dado de baja el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `BajaDeCuentaBancaria`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeCuentaBancaria`(Id int(16), out exito int(11), out salida varchar(50))
begin
	START TRANSACTION;
	if (select count(1) from cuentasbancarias where Uid = Id and Activo = 1) = 0 then
		set @exito = 0;
		set @salida = 'No existe el registro';
	else
		update cuentasbancarias set Activo= 0, FechaBaja=now() where Uid= Id;
		set @exito = 1;
		set @salida = 'Se ha dado de baja el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `BajaDeCuentaContable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeCuentaContable`(Id bigint(16), out exito int(11), out salida varchar(50))
BEGIN
	START TRANSACTION;
	if (select count(1) from cuentascontables where Uid= Id) = 0 then
		set @exito = 0;
		set @salida = 'No existe el registro';
	else
		if (select count(*) from apuntes where Activo = 1 and Cuenta = Id) > 0 then
			set @exito = 0;
			set @salida = 'Existen apuntes asociados a esta cuenta. No puede darse de baja.';
		else
			update cuentascontables set Activo= 0, FechaBaja=now() where Uid= Id;
			set @exito = 1;
			set @salida = 'Se ha dado de baja el registro';
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `BajaDeEventualidad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeEventualidad`(Id bigint(16), out exito int(11), out salida varchar(200))
BEGIN
	START TRANSACTION;
	if  (select count(*) from eventualidades where Uid= Id) = 0 then
		set @exito = 0;
		set @salida = 'No existe el registro';
	else
		update eventualidades set Activo= 0, FechaBaja=now() where Uid= Id;
		set @exito = 1;
		set @salida = 'Se ha dado de baja el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `BajaDeOrganizacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeOrganizacion`(Id bigint(16), out exito int(11), out salida varchar(50))
BEGIN
	START TRANSACTION;
	if (select count(*) from organizaciones where Uid= Id) = 0 then
		set @exito = 0;
		set @salida = 'No existe la organización';
	else
		update organizaciones set Activo= 0, FechaBaja=now() where Uid= Id;
		set @exito = 1;
		set @salida = 'Se ha dado de baja el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `BajaDeTipoMovimiento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BajaDeTipoMovimiento`(Id bigint(16), out exito int(11), out salida varchar(100))
begin
	START TRANSACTION;
	if (select count(*) from tiposmovimientos where Clave = Id) = 0 then
		set @exito = 0;
		set @salida = 'No existe el registro';
	else
		if (select count(*) from movimientos where TipoMovimiento = Id) > 0 then
			set @exito = 0;
			set @salida = 'Hay movimientos asociados a este tipo de movimiento. No se puede borrar';
		else
			delete from tiposmovimientos where Clave = Id;
			set @exito = 1;
			set @salida = 'Se ha dado de baja el registro';
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `BorrarMovimientosNoSaldados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BorrarMovimientosNoSaldados`(out exito int(11), out salida varchar(10))
begin
	
	
	START TRANSACTION;
	update cuentascontables, (select apuntes.Cuenta, apuntes.Debe, apuntes.Haber from apuntes where apuntes.UidMovimiento in ((select Uid from movimientos where TotalDebe <> TotalHaber or (TotalDebe = 0 and TotalHaber = 0)))) as temp set
		cuentascontables.Debe = cuentascontables.Debe - temp.Debe,
		cuentascontables.Haber = cuentascontables.Haber - temp.Haber
	where cuentascontables.Uid = temp.Cuenta;
	delete from apuntes where UidMovimiento in (select Uid from movimientos where TotalDebe <> TotalHaber or (TotalDebe = 0 and TotalHaber = 0));
	delete from movimientos where TotalDebe <> TotalHaber or (TotalDebe = 0 and TotalHaber = 0);
	set @exito= 1;
	set @salida='ok';
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `CancelarApunte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CancelarApunte`(UidApunte int(16), out exito int(11), out salida varchar(50))
begin
	START TRANSACTION;
	set @exito = 0;
	if (select Borrador from movimientos where Uid = (select UidMovimiento from apuntes where Uid = UidApunte)) = 'Si' then
		set @debe = (select Debe from apuntes where Uid = UidApunte);
		set @haber = (select Haber from apuntes where Uid = UidApunte);
		update cuentascontables set
			Debe = Debe - @debe,
			Haber = Haber - @haber
		where Uid = (select Cuenta from apuntes where Uid = UidApunte);
		update movimientos set
			TotalDebe = TotalDebe - @debe,
			TotalHaber = TotalHaber - @haber
		where Uid = (select UidMovimiento from apuntes where Uid = UidApunte);
		delete from apuntes where Uid = UidApunte;
		set @exito = 1;
		set @salida = 'Se ha dado de baja el registro';
	else
		set @salida = 'El movimiento no está en modo Borrador, no se puede modificar';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `CancelarMovimiento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CancelarMovimiento`(UidMov int(16), out exito int(11), out salida varchar(50))
begin
	START TRANSACTION;
	if (select Borrador from movimientos where Uid = UidMov) = 'Si' then
		delete from movimientos where Uid = UidMov;
		set @exito = 1;
		set @salida = 'Se ha dado de baja el registro';
	else
		set @exito = 0;
		set @salida = 'El movimiento no está en modo Borrador, no se puede modificar';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `ClasesInformes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ClasesInformes`(tipo varchar(20), out exito int(11), out seleccion varchar(100))
begin
	set @exito = 1;
	if tipo = "Activo" then
		set @seleccion = 'select Uid, NumeroClase, NombreClase from clases where (NumeroClase = 2 or NumeroClase = 3 or NumeroClase = 4 or NumeroClase = 5) and TipoClase = "Situacion" order by NumeroClase';
	else
		if tipo = "Pasivo" then
			set @seleccion = 'select Uid, NumeroClase, NombreClase from clases where (NumeroClase = 1 or NumeroClase = 4 or NumeroClase = 5) and TipoClase = "Situacion" order by NumeroClase';
		else
			if tipo = "Ingresos" or tipo = "Gastos" then
				set @seleccion = 'select Uid, NumeroClase, NombreClase from clases where NumeroClase >= 6 and TipoClase = "Explotacion" order by NumeroClase';
			else
				if tipo = "Gestion" then
					set @seleccion = 'select Uid, NumeroClase, NombreClase from clases where TipoClase = "Gestion" order by NumeroClase';
				else
					set @exito = 0;
					set @seleccion = 'select Uid from clases where false';
				end if;
			end if;
		end if;
	end if;
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeAmortizacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeAmortizacion`(Bien nvarchar(100),  FIni date, FFin date, Num varchar(10), Concept varchar(40), Orig varchar(40), PriceInf float, PriceSup float, OUT exito int(11), OUT salida varchar(200))
begin
	START TRANSACTION;
	set @exito = 1;
	set @seleccion = concat_ws(' where ', 'select amortizaciones.Uid, clasesbienes.Tipo, FechaCompra, Numero, Concepto, Origen, Precio, Acumulado, Anual, VNC from clasesbienes, amortizaciones ',
									concat_ws(' and ',   concat(' clasesbienes.Uid =', Bien, ' '),
													concat(' FechaCompra >= ', FIni),
													concat(' FechaCompra <= ', FFin),
													concat(' Numero like "%', Num, '%" '),
													concat(' Concepto like "%', Concept, '%" '),
													concat(' Origen like "%', Orig, '%" '),
													concat(' Precio  >= ', PriceInf),
													concat(' Precio  <= ', PriceSup),
													concat(' clasesbienes.Uid = amortizaciones.UidClasesBienes ')
												)
							);
	select @exito,@seleccion;
END$$

DROP PROCEDURE IF EXISTS `ConsultaDeApuntes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeApuntes`(Id bigint(16), out exito int(11), out seleccion varchar(200))
begin
	START TRANSACTION;
	set @exito = 1;
	set @seleccion = concat('select apuntes.Uid, Fecha, Moneda, cuentascontables.NumeroCuenta, cuentascontables.NombreCuenta, Concepto, apuntes.Debe, apuntes.Haber, Referencia from apuntes inner join cuentascontables on cuentascontables.Uid = apuntes.Cuenta where cuentascontables.Activo = 1 and UidMovimiento = ', Id);
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeCategorias`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeCategorias`(out exito int(11), out seleccion varchar(500))
begin
	START TRANSACTION;
	set @exito = 1;
	set @seleccion = 'select Uid, Categoria, SueldoBase, Vivienda, Desplazamiento from categorias where Activo = 1';
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeClase`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeClase`(out exito int(11), out seleccion varchar(50))
begin
	START TRANSACTION;
	set @exito = 1;
	set @seleccion = 'select * from clases';
	select @exito,@seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeClaseBien`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeClaseBien`(obj varchar(100), out exito int(11), out seleccion varchar(100))
begin
	set @exito = 1;
	if obj is null then
		set @seleccion = 'select * from clasesbienes where true';
	else
		set @seleccion = concat("select * from clasesbienes where Tipo = '", obj, "'");
	end if;
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeCondicion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeCondicion`(Fechini date, Fechfin date, Nomb varchar(50), Apell varchar(50), Codigo varchar(10), NumIden varchar(20), out exito int(11), out seleccion varchar(800))
begin
	START TRANSACTION;
	set @exito = 1;
	set @seleccion = concat_ws(' where ','select condiciones.Uid, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, FechaInicio, FechaFin, DiasTrabajados, categorias.Categoria, SSocial, SSocialPatr, SeguroMedico, SeguroMedicoPatr, Familia, personas.CodigoPersona from condiciones, categorias, kumenya_matriculacion.personas ',
							concat_ws(' and ', concat(' FechaInicio >= ''', Fechini,''''),
											concat(' FechaFin <= "', Fechfin, '"'),
											concat('UidPersona in (Select Uid from kumenya_matriculacion.personas where Nombre like "%' , Nomb, '%")'),
											concat('UidPersona in (Select Uid from kumenya_matriculacion.personas where Apellidos  like "%' , Apell, '%")'),
											concat('UidPersona in (Select Uid from kumenya_matriculacion.personas where CodigoPersona  like "%' , Codigo, '%")'),
											concat('UidPersona in (Select Uid from kumenya_matriculacion.personas where NumIdentificacion  like "%' , NumIden, '%")'),
											concat('condiciones.Activo=1 and condiciones.UidPersona = kumenya_matriculacion.personas.Uid and condiciones.UidCategoria = categorias.Uid')
									)
							);
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeCuentaBancaria`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeCuentaBancaria`(out exito int(11), out seleccion varchar(50))
begin
	set @exito = 1;
	set @seleccion = 'select Uid, Cuenta, Banco from cuentasbancarias where Activo = 1';
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeCuentaBancariaOrganizaciones`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeCuentaBancariaOrganizaciones`(banc varchar(40), out exito int(11), out seleccion varchar(300))
begin
	START TRANSACTION;
	set @exito = 1;
	set @criterio = 'cuentasbancarias.Activo = 1 and organizaciones.Uid = UidTercero and TipoTercero = "Organizacion"';
	if banc is not null then
		set @criterio = concat(@criterio, " and Banco like '%", banc, "%'");
	end if;
	set @seleccion = concat('select cuentasbancarias.Uid, organizaciones.Nombre, organizaciones.NumIdentificacion, Cuenta, Banco, TipoTercero from cuentasbancarias, organizaciones where ', @criterio);
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeCuentaBancariaPersonas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeCuentaBancariaPersonas`(banc varchar(40), out exito int(11), out seleccion varchar(300))
begin
	START TRANSACTION;
	set @exito = 1;
	set @criterio = 'cuentasbancarias.Activo = 1 and kumenya_matriculacion.personas.Uid = UidTercero and TipoTercero = "Persona"';
	if banc is not null then
		set @criterio = concat(@criterio, " and Banco like '%", banc, "%'");
	end if;
	set @seleccion = concat('select cuentasbancarias.Uid, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.NumIdentificacion, Cuenta, Banco, TipoTercero from cuentasbancarias, kumenya_matriculacion.personas where ', @criterio);
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeCuentaContableNinguno`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeCuentaContableNinguno`(nomcuenta varchar(100), numcuenta varchar(10), numcla int(5), nomcla varchar(100), tipter enum('Ninguno','Organizacion','Persona','Todos'), tipo enum('Activo','Pasivo','Ingresos','Gastos','Explotacion','Todos'), out exito int(11), out seleccion varchar(600))
begin
	START TRANSACTION;
	set @criterio2 = ') and cuentascontables.Activo = 1 and clases.Uid = cuentascontables.UidClase and TipoTercero = "Ninguno"';
	set @criterio = concat('cuentascontables.UidClase in (select Uid from clases where NumeroClase like ', concat_ws('%', "'",numcla,"'" ), ' and NombreClase like ', concat_ws('%', "'",nomcla,"'" ),@criterio2);
	if nomcuenta is not null then
		set @criterio = concat(@criterio, " and NombreCuenta like '%", nomcuenta, "%'");
	end if;
	if numcuenta is not null then
		set @criterio = concat(@criterio, " and NumeroCuenta like '%", numcuenta,  "%'");
	end if;
	if numcla is not null then
		set @criterio = concat(@criterio, " and NumeroClase like '%", numcla, "%'");
	end if;
	if nomcla is not null then
		set @criterio = concat(@criterio, " and NombreClase = '%", nomcla,  "%'");
	end if;
	if (tipo = 'Activo' or tipo = 'Pasivo' or tipo = 'Ingresos' or tipo = 'Gastos' or tipo = 'Explotacion') then
		set @criterio =concat(@criterio, " and TipoCuenta = '", tipo, "'");
	end if;
	set @seleccion = concat('select cuentascontables.Uid, clases.NumeroClase, clases.NombreClase, NumeroCuenta, NombreCuenta, Debe, Haber, TipoCuenta from cuentascontables, clases where ', @criterio);
	set @exito = 1;
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeCuentaContableOrganizaciones`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeCuentaContableOrganizaciones`(nomcuenta varchar(100), numcuenta varchar(10), numcla int(5), nomcla varchar(100), tipter enum('Ninguno','Organizacion','Persona','Todos'), tipo enum('Activo','Pasivo','Ingresos','Gastos','Explotacion','Todos'),  out exito int(11), out seleccion varchar(600))
begin
	START TRANSACTION;
	set @exito = 1;
	set @criterio2 = ') and cuentascontables.Activo = 1 and organizaciones.Uid = UidTercero and clases.Uid = cuentascontables.UidClase and TipoTercero = "Organizacion"';
	set @criterio = concat('cuentascontables.UidClase in (select Uid from clases where NumeroClase like ', concat_ws('%', "'",numcla,"'" ), ' and NombreClase like ', concat_ws('%', "'",nomcla,"'" ),@criterio2);
	if nomcuenta is not null then
		set @criterio = concat(@criterio, " and NombreCuenta like '%", nomcuenta, "%'");
	end if;
	if numcuenta is not null then
		set @criterio = concat(@criterio, " and NumeroCuenta like '%", numcuenta,  "%'");
	end if;
	if numcla is not null then
		set @criterio = concat(@criterio, " and NumeroClase like '%", numcla, "%'");
	end if;
	if nomcla is not null then
		set @criterio = concat(@criterio, " and NombreClase like '%", nomcla, "%'");
	end if;
	if (tipo = 'Activo' or tipo = 'Pasivo' or tipo = 'Ingresos' or tipo = 'Gastos' or tipo = 'Explotacion') then
		set @criterio =concat(@criterio, " and TipoCuenta = '", tipo, "'");
	end if;
	set @seleccion = concat('select cuentascontables.Uid, clases.NumeroClase, clases.NombreClase, organizaciones.Nombre, organizaciones.NumIdentificacion, cuentascontables.NumeroCuenta, cuentascontables.NombreCuenta, Debe, Haber, TipoCuenta from cuentascontables, organizaciones, clases where ', @criterio);
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeCuentaContablePersonas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeCuentaContablePersonas`(nomcuenta varchar(100), numcuenta varchar(10), numcla int(5), nomcla varchar(100), tipter enum('Ninguno','Organizacion','Persona','Todos'), tipo enum('Activo','Pasivo','Ingresos','Gastos','Explotacion','Todos'), out exito int(11), out seleccion varchar(600))
begin
	START TRANSACTION;
	set @exito = 1;
	set @criterio2 = ') and cuentascontables.Activo = 1 and kumenya_matriculacion.personas.Uid = UidTercero and clases.Uid = cuentascontables.UidClase and TipoTercero = "Persona"';
	set @criterio = concat('cuentascontables.UidClase in (select Uid from clases where NumeroClase like ', concat_ws('%', "'",numcla,"'" ), ' and NombreClase like ', concat_ws('%', "'",nomcla,"'" ),@criterio2);
	if nomcuenta is not null then
		set @criterio = concat(@criterio, " and NombreCuenta like '%", nomcuenta, "%'");
	end if;
	if numcuenta is not null then
		set @criterio = concat(@criterio, " and NumeroCuenta like '%", numcuenta,  "%'");
	end if;
	if numcla is not null then
		set @criterio = concat(@criterio, " and NumeroClase like '%", numcla, "%'");
	end if;
	if nomcla is not null then
		set @criterio = concat(@criterio, " and NombreClase like '%", nomcla, "%'");
	end if;
	if (tipo = 'Activo' or tipo = 'Pasivo' or tipo = 'Ingresos' or tipo = 'Gastos' or tipo = 'Explotacion') then
		set @criterio =concat(@criterio, " and TipoCuenta = '", tipo, "'");
	end if;
	set @seleccion = concat('select cuentascontables.Uid, clases.NumeroClase, clases.NombreClase, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.NumIdentificacion, cuentascontables.NumeroCuenta, cuentascontables.NombreCuenta, Debe, Haber, TipoCuenta from cuentascontables, kumenya_matriculacion.personas, clases where ', @criterio);
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeEventualidad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeEventualidad`(Nomb varchar(50), Apell varchar(50), Codigo varchar(10), NumIden varchar(20), Concept varchar(100), Tip enum('Abono','Descuento'), FechIni date, FechFin date, out exito int(11), out seleccion varchar(1000))
begin
	START TRANSACTION;
	set @exito = 1;
	set @seleccion = concat_ws(' where ','select eventualidades.Uid, Concepto, Importe, Tipo, Aplicado, FechaInicio, FechaFin, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.Nombre from eventualidades, kumenya_matriculacion.personas ',
						concat_ws(' and ', concat(' Concepto like ''%', Concept,'%'' '),
										concat(' Tipo like ''%', Tip,'%'' '),
										concat(' FechaInicio >= ''', FechIni,''''),
										concat(' FechaFin <= "', FechFin, '"'),
										concat('UidPersona in (Select Uid from kumenya_matriculacion.personas where Nombre like "%' , Nomb, '%")'),
										concat('UidPersona in (Select Uid from kumenya_matriculacion.personas where Apellidos  like "%' , Apell, '%")'),
										concat('UidPersona in (Select Uid from kumenya_matriculacion.personas where CodigoPersona  like "%' , Codigo, '%")'),
										concat('UidPersona in (Select Uid from kumenya_matriculacion.personas where NumIdentificacion  like "%' , NumIden, '%")'),
										concat('eventualidades.Activo=1 and eventualidades.UidPersona = kumenya_matriculacion.personas.Uid')
								)
						);
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeMovimiento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeMovimiento`(fechini varchar(10), fechfin varchar(10), out exito int(11), out seleccion varchar(400))
begin
	START TRANSACTION;
	set @exito = 1;
	set @seleccion = 'select Uid from movimientos where ';
	if fechini is null and fechfin is null then
		set @seleccion = concat(@seleccion, 'true');
	else
		if fechini is null and fechfin is not null then
			set @seleccion = concat(@seleccion, 'Uid in (select UidMovimiento from apuntes where Fecha <= "', fechfin, '")');
		else
			if fechini is not null and fechfin is null then
				set @seleccion = concat(@seleccion, 'Uid in (select UidMovimiento from apuntes where "', fechini, '" <= Fecha)');
			else
				set @seleccion = concat(@seleccion, 'Uid in (select UidMovimiento from apuntes where ("', fechini, '" <= Fecha and Fecha <= "', fechfin, '"))');
			end if;
		end if;
	end if;
	set @seleccion = concat(@seleccion, ' order by Numero');
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeNominas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeNominas`(Id bigint(16), mes varchar(10), out exito int(11), out seleccion varchar(200))
begin
	set @exito = 1;
	set @criterio = ' ';
	if Id is not null then
		set @criterio = concat(' and nominas.UidPersona = ', Id);
	end if;
	if mes is not null then
		set @criterio = concat(" and month(nominas.FechaEmision) = month('", mes, "')", @criterio);
	end if;
	set @seleccion = concat("select kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, SueldoBase, AyudaVivienda, AyudaDesplazamiento, EvAbonoBruto, EvDescuentoBruto, SueldoBruto, AyudaFamilia, ",
						 "SeguridadSocialEmpleado, MutualidadEmpleado, SeguridadSocialPatron, MutualidadPatron, IPR, R, ImpuestoBruto, ImpuestoNeto, EvAbonoNeto, EvDescuentoNeto, SalarioNeto, DiasTrabajados, FechaEmision from ",
                                                 "nominas, kumenya_matriculacion.personas where UidPersona = kumenya_matriculacion.personas.Uid and Contrato = 'Si'", @criterio);
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeOrganizacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeOrganizacion`(nombre varchar(50), numIdentificacion varchar(20), out exito int(11), out seleccion varchar(600))
begin
	START TRANSACTION;
	set @exito = 1;
	set @seleccion = concat_ws('where','select Uid, Nombre, NumIdentificacion from organizaciones ', concat_ws(" and ", concat(" Nombre= '%", nombre, "%' "), concat(" NumIdentificacion= '%", numIdentificacion, "%' ")," Activo=1 "));
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDePagas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDePagas`(Id bigint(16), mes varchar(10), out exito int(11), out seleccion varchar(200))
begin
	set @exito = 1;
	set @criterio = ' ';
	if Id is not null then
		set @criterio = concat(' and nominas.UidPersona = ', Id);
	end if;
	if mes is not null then
		set @criterio = concat(" and month(nominas.FechaEmision) = month('", mes, "')", @criterio);
	end if;
	set @seleccion = concat("select kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, SueldoBase, EvAbonoBruto, EvDescuentoBruto, SueldoBruto, SalarioNeto, DiasTrabajados, FechaEmision from ",
                                                 "nominas, kumenya_matriculacion.personas where UidPersona = kumenya_matriculacion.personas.Uid and Contrato = 'No'", @criterio);
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `ConsultaDeTipoMovimiento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaDeTipoMovimiento`(out exito int(11), out seleccion varchar(50))
begin
	set @exito = 1;
	set @seleccion = 'select * from tiposmovimientos';
	select @exito,@seleccion;
end$$

DROP PROCEDURE IF EXISTS `ConsultaMovimientosApuntes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaMovimientosApuntes`(Id bigint(16), out exito int(11), out seleccion varchar(400))
begin
	START TRANSACTION;
	set @exito = 1;
	set @seleccion = concat('select Fecha, Moneda, cuentascontables.NumeroCuenta, cuentascontables.NombreCuenta, Concepto, apuntes.Debe, apuntes.Haber, Referencia from apuntes, cuentascontables where cuentascontables.Uid = apuntes.Cuenta and UidMovimiento = ', Id);
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `ConsultaMovimientosMovimientos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaMovimientosMovimientos`(Id bigint(16), out exito int(11), out seleccion varchar(400))
begin
	START TRANSACTION;
	set @exito = 1;
	set @seleccion = concat('select Uid, Numero, Borrador, TotalDebe, TotalHaber from movimientos where Uid = ', Id);
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `ConsultaTotalDebeHaber`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaTotalDebeHaber`(UidMov bigint(16), OUT exito int(11), OUT seleccion varchar(400))
BEGIN
	START TRANSACTION;
        set @seleccion = concat_ws(' where ', 'select TotalDebe,TotalHaber from movimientos ',concat('Uid =', UidMov));
	set @exito=1;
	select @exito, @seleccion;
	COMMIT;
END$$

DROP PROCEDURE IF EXISTS `CuentasEnIntervalo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CuentasEnIntervalo`(Idini bigint(16), Idfin bigint(16), out exito int(11), out seleccion varchar(100))
begin
	
	set @exito = 1;
	set @inicial = (select NumeroCuenta from cuentascontables where Uid = Idini);
	set @final = (select NumeroCuenta from cuentascontables where Uid = Idfin);
	set @seleccion = concat('select Uid,TipoTercero from cuentascontables where ', @inicial, ' <= NumeroCuenta and NumeroCuenta <= ', @final);
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `CuentasInformes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CuentasInformes`(Id bigint(16), tipo varchar(20), out exito int(11), out seleccion varchar(200))
begin
	set @exito = 1;
	if tipo = "Activo" then
		set @seleccion = concat('select Uid, TipoTercero from cuentascontables where UidClase = ', Id, ' and Padre is null and TipoCuenta = "Activo" and Activo = 1 order by NumeroCuenta');
	else
		if tipo = "Pasivo" then
			set @seleccion = concat('select Uid, TipoTercero from cuentascontables where UidClase = ', Id, ' and Padre is null and TipoCuenta = "Pasivo"  and Activo = 1 order by NumeroCuenta');
		else
			if tipo = "Ingresos" then
				set @seleccion = concat('select Uid, TipoTercero from cuentascontables where UidClase = ', Id, ' and Padre is null and TipoCuenta = "Ingresos"  and Activo = 1 order by NumeroCuenta');
			else
				if tipo = "Gastos" then
					set @seleccion = concat('select Uid, TipoTercero from cuentascontables where UidClase = ', Id, ' and Padre is null and TipoCuenta = "Gastos"  and Activo = 1 order by NumeroCuenta');
				else
					if tipo = "Gestion" then
						set @seleccion = concat('select Uid, TipoTercero from cuentascontables where UidClase = ', Id, 'and Padre is null and TipoCuenta = "Gestion" and Activo = 1 order by NumeroCuenta');
					else
						set @exito = 0;
						set @seleccion = 'select Uid, TipoTercero from cuentascontables where false';
					end if;
				end if;
			end if;
		end if;
	end if;
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `DetalleDeApunte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleDeApunte`(Id bigint(16), out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	set @exito = 1;
	set @salida= concat('select apuntes.Uid, UidMovimiento as Uidmovimientos, Fecha, Moneda, Cuenta as Uidcuentascontables, cuentascontables.NumeroCuenta, cuentascontables.NombreCuenta, Concepto, apuntes.Debe, apuntes.Haber, Referencia from apuntes inner join cuentascontables on apuntes.Cuenta = cuentascontables.Uid where apuntes.Uid = ', Id);
	select @exito, @salida;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `DetalleDeCondicion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleDeCondicion`(Id bigint(16), out exito int(11), out seleccion varchar(100))
begin
	START TRANSACTION;
	set @exito = 1;
	set @seleccion = concat('select condiciones.Uid, condiciones.UidCategoria as Uidcategorias, categorias.Categoria, kumenya_matriculacion.personas.Uid as Uidpersonas, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona, kumenya_matriculacion.personas.TipoPersona, FechaInicio, FechaFin, DiasTrabajados, SSocial, SSocialPatr, SeguroMedico, SeguroMedicoPatr, Familia from condiciones, kumenya_matriculacion.personas, categorias where kumenya_matriculacion.personas.Uid = UidPersona and categorias.Uid = condiciones.UidCategoria and condiciones.Uid = ',Id);
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `DetalleDeCuentaBancariaOrganizaciones`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleDeCuentaBancariaOrganizaciones`(Id bigint(16), out exito int(11), out seleccion varchar(200))
begin
	START TRANSACTION;
	set @exito = 1;
	set @seleccion = 'select cuentasbancarias.Uid, organizaciones.Uid as Uidorganizaciones, organizaciones.Nombre, organizaciones.Apellidos, organizaciones.NumIdentificacion, organizaciones.Direccion, organizaciones.Distrito, organizaciones.Localidad, organizaciones.Provincia, organizaciones.Pais, cuentasbancarias.Cuenta, cuentasbancarias.Banco, cuentasbancarias.TipoTercero from cuentasbancarias inner join organizaciones';
	set @seleccion = concat(@seleccion, ' where cuentasbancarias.Activo = 1 and cuentasbancarias.TipoTercero = "Organizacion" and organizaciones.Uid = cuentasbancarias.UidTercero and cuentasbancarias.Uid = ',Id);
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `DetalleDeCuentaBancariaPersonas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleDeCuentaBancariaPersonas`(Id bigint(16), out exito int(11), out seleccion varchar(300))
begin
	START TRANSACTION;
	set @exito = 1;
	set @seleccion = 'select cuentasbancarias.Uid, kumenya_matriculacion.personas.Uid as Uidpersonas, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.NumIdentificacion, kumenya_matriculacion.personas.Direccion, kumenya_matriculacion.personas.Distrito, kumenya_matriculacion.personas.Localidad, kumenya_matriculacion.personas.Provincia, kumenya_matriculacion.personas.Pais, Cuenta, Banco, TipoTercero from cuentasbancarias inner join kumenya_matriculacion.personas';
	set @seleccion = concat(@seleccion, ' where cuentasbancarias.Activo = 1 and cuentasbancarias.TipoTercero = "Persona" and kumenya_matriculacion.personas.Uid = cuentasbancarias.UidTercero and cuentasbancarias.Uid = ',Id);
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `DetalleDeCuentaContableNinguno`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleDeCuentaContableNinguno`(Id bigint(16), out exito int(11), out seleccion varchar(700))
begin
	START TRANSACTION;
	set @exito = 1;
	set @seleccion = 'select cuentascontables.Uid, cuentascontables.UidClase, cuentascontables.TipoCuenta, cuentascontables.NumeroCuenta, cuentascontables.NombreCuenta, cuentascontables.Debe, cuentascontables.Haber, cuentascontables.TipoTercero, cuentascontables.Padre from cuentascontables inner join clases';
	set @seleccion = concat(@seleccion, ' where cuentascontables.Activo = 1 and cuentascontables.TipoTercero = "Ninguno" and clases.Uid = cuentascontables.UidClase and cuentascontables.Uid = ',Id);
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `DetalleDeCuentaContableOrganizaciones`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleDeCuentaContableOrganizaciones`(Id bigint(16), out exito int(11), out seleccion varchar(1000))
begin
	START TRANSACTION;
	set @exito = 1;
	set @seleccion = 'select cuentascontables.Uid, organizaciones.Uid as Uidorganizaciones, organizaciones.Nombre, organizaciones.Apellidos, organizaciones.NumIdentificacion, organizaciones.Direccion, organizaciones.Distrito, organizaciones.Localidad, organizaciones.Provincia, organizaciones.Pais, cuentascontables.UidClase,  cuentascontables.TipoCuenta, cuentascontables.NumeroCuenta, cuentascontables.NombreCuenta, cuentascontables.Debe, cuentascontables.Haber, cuentascontables.TipoTercero, cuentascontables.Padre from cuentascontables inner join organizaciones, clases';
	set @seleccion = concat(@seleccion, ' where cuentascontables.Activo = 1 and cuentascontables.TipoTercero = "Organizacion" and organizaciones.Uid = cuentascontables.UidTercero and clases.Uid = cuentascontables.UidClase and cuentascontables.Uid = ',Id);
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `DetalleDeCuentaContablePersonas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleDeCuentaContablePersonas`(Id bigint(16), out exito int(11), out seleccion varchar(1000))
begin
	START TRANSACTION;
	set @exito = 1;
	set @seleccion = 'select cuentascontables.Uid, kumenya_matriculacion.personas.Uid as Uidpersonas, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.NumIdentificacion, kumenya_matriculacion.personas.Direccion, kumenya_matriculacion.personas.Distrito, kumenya_matriculacion.personas.Localidad, kumenya_matriculacion.personas.Provincia, kumenya_matriculacion.personas.Pais, cuentascontables.UidClase,  cuentascontables.TipoCuenta, cuentascontables.NumeroCuenta, cuentascontables.NombreCuenta, cuentascontables.Debe, cuentascontables.Haber, cuentascontables.TipoTercero, cuentascontables.Padre from cuentascontables inner join kumenya_matriculacion.personas, clases';
	set @seleccion = concat(@seleccion, ' where cuentascontables.Activo = 1 and cuentascontables.TipoTercero = "Persona" and kumenya_matriculacion.personas.Uid = cuentascontables.UidTercero and clases.Uid = cuentascontables.UidClase and cuentascontables.Uid = ',Id);
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `DetalleDeEventualidad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleDeEventualidad`(Id bigint(16), OUT exito int(11), OUT salida varchar(800))
begin
	START TRANSACTION;
	set @exito = 1;
	set @salida= concat('select eventualidades.Uid, eventualidades.UidPersona as Uidpersonas, eventualidades.Concepto, ',
				'eventualidades.Importe, eventualidades.Aplicado, ',
				'eventualidades.Tipo, eventualidades.FechaInicio, eventualidades.FechaFin, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_matriculacion.personas.CodigoPersona,',
				'kumenya_matriculacion.personas.TipoPersona from eventualidades, kumenya_matriculacion.personas where kumenya_matriculacion.personas.Uid = eventualidades.UidPersona and eventualidades.Uid =', Id);
	select @exito, @salida;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `DetalleDeOrganizacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DetalleDeOrganizacion`(Id bigint(16), out exito int(11), out salida varchar(100))
begin
	START TRANSACTION;
	set @exito = 1;
	set @salida = concat('select Uid, Nombre, Apellidos, NumIdentificacion, Direccion, Distrito, Localidad, Provincia, Pais from organizaciones where Activo = 1 and Uid = ', Id);
	select @exito, @salida;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `DeudaInscripcion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeudaInscripcion`(Id bigint(16), out exito int(11), out salida varchar(50))
begin
	START TRANSACTION;
	set @exito = 0;

	set @num = mid((select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'MovimientosAutomaticos'), 2) + 1;
	update kumenya_biblioteca.configuracion set
		Valor = concat( 'K', @num)
	where NombreAtributo = 'MovimientosAutomaticos';
	insert into movimientos (Numero, Borrador, TotalDebe, TotalHaber, Activo, FechaCreacion, FechaModificacion)
	values (concat('K',@num), 'No', 0, 0, 1, now(), now());
	set @ulti = LAST_INSERT_ID();

	set @cantidad = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'TasaMatricula');

	set @literal = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'ApunteDeudaTasaMatricula');

	set @cuenalumno = (select cuentascontables.Uid from cuentascontables, kumenya_matriculacion.personas where cuentascontables.UidTercero = Id and kumenya_matriculacion.personas.Uid = Id and cuentascontables.TipoTercero = 'Persona');
	insert into apuntes (UidMovimiento, Fecha, Moneda, Cuenta, Concepto, Debe, Haber, Referencia, Activo, FechaCreacion, FechaModificacion)
	values (@ulti, now(), 'FBU', @cuenalumno, @literal, @cantidad, 0, null, 1, now(), now());

	update cuentascontables set Debe = Debe + @cantidad where Uid = @cuenalumno;


	insert into apuntes (UidMovimiento, Fecha, Moneda, Cuenta, Concepto, Debe, Haber, Referencia, Activo, FechaCreacion, FechaModificacion)
	values (@ulti, now(), 'FBU', (select Uid from cuentascontables where NumeroCuenta = '74.1'), @literal, 0, @cantidad, null, 1, now(), now());

	update cuentascontables set Haber = Haber + @cantidad where NumeroCuenta = '74.1';


	update movimientos set
		TotalDebe = TotalDebe + @cantidad,
		TotalHaber = TotalHaber + @cantidad
	where Uid = @ulti;
	set @exito = 1;
	set @salida = 'Apunte insertado';
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `DeudaMatricula`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeudaMatricula`(Id bigint(16), out exito int(11), out salida varchar(50))
begin
	START TRANSACTION;
	set @exito = 0;

	set @num = mid((select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'MovimientosAutomaticos'), 2) + 1;
	update kumenya_biblioteca.configuracion set
		Valor = concat( 'K', @num)
	where NombreAtributo = 'MovimientosAutomaticos';
	insert into movimientos (Numero, Borrador, TotalDebe, TotalHaber, Activo, FechaCreacion, FechaModificacion)
	values (concat('K',@num), 'No', 0, 0, 1, now(), now());
	set @ulti = LAST_INSERT_ID();




	set  @nacionalidad = 1;
	set @pais = (select Pais from kumenya_matriculacion.paises where Uid = (select Pais from kumenya_matriculacion.personas where Uid = Id));
	if @pais <> 'Burundi' then
		set @nacionalidad = 0;
	end if;

	set @matricula = (select Uid from kumenya_matriculacion.matriculas where UidAlumno = Id and Anio = year(convert((select Valor from kumenya_biblioteca.configuracion where NombreAtributo='FechaInicioCurso'), date)));

	set @asignatura = (select max(UidAsignatura) from kumenya_matriculacion.matriculasasignaturas where UidMatricula = @matricula);

	set @carrera = (select Carrera from kumenya_matriculacion.asignaturas where Uid = @asignatura);

	if @nacionalidad = 1 then
		set @cantidad = (select PrecioNacional from kumenya_matriculacion.carreras where Uid = @carrera);
	else
		set @cantidad = (select PrecioExtranjero from kumenya_matriculacion.carreras where Uid = @carrera) * (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'CambioFBUUSD');
	end if;





	set @cuenalumno = (select cuentascontables.Uid from cuentascontables, kumenya_matriculacion.personas where cuentascontables.UidTercero = Id and kumenya_matriculacion.personas.Uid = Id and cuentascontables.TipoTercero = 'Persona');
	set @literal = (select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'ApunteDeudaMatricula');
	insert into apuntes (UidMovimiento, Fecha, Moneda, Cuenta, Concepto, Debe, Haber, Referencia, Activo, FechaCreacion, FechaModificacion)
	values (@ulti, now(), 'FBU', @cuenalumno, @literal, 0, @cantidad, null, 1, now(), now());

	update cuentascontables set Haber = Haber + @cantidad where Uid = @cuenalumno;


	insert into apuntes (UidMovimiento, Fecha, Moneda, Cuenta, Concepto, Debe, Haber, Referencia, Activo, FechaCreacion, FechaModificacion)
	values (@ulti, now(), 'FBU', (select Uid from cuentascontables where NumeroCuenta = '71'), @literal, @cantidad, 0, null, 1, now(), now());

	update cuentascontables set Debe = Debe + @cantidad where NumeroCuenta = '71';


	update movimientos set
		TotalDebe = TotalDebe + @cantidad,
		TotalHaber = TotalHaber + @cantidad
	where Uid = @ulti;
	set @exito = 1;
	set @salida = 'Apunte insertado';
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `ErrorNomina`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ErrorNomina`(Id bigint(16), out exito int(11), out salida varchar(100) )
begin
	set @exito = 1;
	set @person = (select UidPersona from condiciones where Uid = Id);
	set @salida = (select concat(personas.Nombre," ", personas.Apellidos) as Empleado from kumenya_matriculacion.personas where Uid = @person);
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `GeneracionDeNomina`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GeneracionDeNomina`(UidCondiciones bigint(16), mes date, out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	
	set @UidPer = (select UidPersona from condiciones  where Uid=UidCondiciones and Activo = 1);
	if @UidPer is null then
		
		set @exito = 0;
		set @salida = 'no tiene condiciones activas';
	else
		if (select count(*) from nominas where UidPersona = @UidPer and month(mes) = month(FechaEmision)) > 0 then
			set @exito = 0;
			set @salida = 'ya tiene nómina para este mes';
		else
			
			set @DiasCurro = (select DiasTrabajados from condiciones where Uid = UidCondiciones);
			
			set @SBase = (select SueldoBase from categorias where Uid = (select UidCategoria from condiciones  where Uid=UidCondiciones and Activo = 1) and Activo = 1);
			set @SBase = round((@SBase * @DiasCurro) / 30,0);
			set @ADesplaz = (select Desplazamiento from categorias where Uid = (select UidCategoria from condiciones  where Uid=UidCondiciones and Activo = 1) and Activo = 1);
			set @AVivienda = (select Vivienda from categorias where Uid = (select UidCategoria from condiciones  where Uid=UidCondiciones and Activo = 1) and Activo = 1);
			
			set @EvAbBruto = (select sum(Importe) from eventualidades where UidPersona = @UidPer and Tipo='Abono' and Aplicado = 'Bruto' and FechaInicio <=  mes and mes <= FechaFin and Activo = 1);
			if @EvAbBruto is null then
				set @EvAbBruto = 0;
			end if;
			set @EvDesBruto = (select sum(Importe) from eventualidades where UidPersona = @UidPer and Tipo='Descuento' and Aplicado = 'Bruto' and FechaInicio <= mes and mes <= FechaFin and Activo = 1);
			if @EvDesBruto is null then
				set @EvDesBruto = 0;
			end if;

			set @SBruto = @SBase + @ADesplaz + @AVivienda + @EvAbBruto - @EvDesBruto;
			
			if (select SSocial from condiciones where UidPersona = @UidPer and Activo = 1 and FechaInicio <= mes and mes <= FechaFin) = 'Si' then

				if @SBruto > 150000 then
					set @INSSemp = 3900;
				else
					set @INSSemp = round(@SBruto * 0.026,0);
				end if;
			else
				set @INSSemp = 0;
			end if;
			if (select SSocialPatr from condiciones where UidPersona = @UidPer and Activo = 1 and FechaInicio <= mes and mes <= FechaFin) = 'Si' then
				if @SBruto > 150000 then
					set @INSSpat = 5850;
				else
					set @INSSpat = round(@SBruto * 0.039,0);
				end if;
				if @SBruto > 80000 then
					set @INSSpat = @INSSpat + 2400;
				else
					set @INSSpat = @INSSpat + round(@SBruto * 0.03,0);
				end if;
			else
				set @INSSpat = 0;
			end if;
			if (select SeguroMedico from condiciones where UidPersona = @UidPer and Activo = 1 and FechaInicio <= mes and mes <= FechaFin) = 'Si' then
				
				set @Mutemp = round(@SBase * 0.04,0);
			else
				set @Mutemp = 0;
			end if;
			if (select SeguroMedicoPatr from condiciones where UidPersona = @UidPer and Activo = 1 and FechaInicio <= mes and mes <= FechaFin) = 'Si' then
				
				set @Mutpat = round(@SBase * 0.06,0);
			else
				set @Mutpat = 0;
			end if;

      if (@ADesplaz > @SBase * 15 / 100) then
        set @ADesplazImp = @ADesplaz - (@SBase * 15 / 100);
      else
        set @ADesplazImp = 0;
      end if;

      if (@AVivienda > @SBase * 60 / 100) then
        set @AViviendaImp = @AVivienda - (@SBase * 15 / 100);
      else
        set @AViviendaImp = 0;
      end if;

      set @RBI = @SBase + @ADesplazImp + @AViviendaImp;

			set @RNI = round((@RBI + (@RBI * 0.1) - @INSSemp - @Mutemp),0);
			
			if (@RNI > 40000) then
				set @R = @RNI - 40000;
			else
				set @R = 0;
			end if;
			
			
			set @Coef = (select Coeficiente from baremomesoficial where @R >= Inferior and @R <= Superior);
			set @Sust = (select Sustraendo from baremomesoficial where @R >= Inferior and @R <= Superior);
			if @Coef = 0 then
				set @ImpBr = 0;
			else
				set @ImpBr = round(((@R * @Coef) - @Sust),0);
			end if;
			
			set @Fam =  (select Familia from condiciones where Uid = UidCondiciones and Activo = 1);
			if @Fam > 4 then
				set @Fam = 4;
			end if;
			if (@ImpBr <> 0) then
				set @ImpNeto = @ImpBr - (113 * @Fam);
			else
				set @ImpNeto = 0;
			end if;

			if (round(@RNI * 0.35,0) > @ImpNeto) then
				set @ImpNeto = round(@RNI * 0.35,0);
			end if;
			
			set @EvAbNeto = (select sum(Importe) from eventualidades where UidPersona = @UidPer and Tipo='Abono' and Aplicado = 'Neto' and FechaInicio <= mes and mes <= FechaFin and Activo = 1);
			if @EvAbNeto is null then
				set @EvAbNeto = 0;
			end if;
			set @EvDesNeto = (select sum(Importe) from eventualidades where UidPersona = @UidPer and Tipo='Descuento' and Aplicado = 'Neto' and FechaInicio <= mes and mes <= FechaFin and Activo = 1);
			if @EvDesNeto is null then
				set @EvDesNeto = 0;
			end if;
			set @SNeto = @SBruto - @INSSemp - @Mutemp - @ImpNeto + @EvAbNeto - @EvDesNeto;
			
			insert into nominas (UidPersona, SueldoBase, AyudaVivienda, AyudaDesplazamiento, EvAbonoBruto, EvDescuentoBruto, SueldoBruto, AyudaFamilia, SeguridadSocialEmpleado, MutualidadEmpleado, SeguridadSocialPatron, MutualidadPatron,
							IPR, R, ImpuestoBruto, ImpuestoNeto, EvAbonoNeto, EvDescuentoNeto, SalarioNeto, DiasTrabajados, FechaEmision, Contrato)
			values (@UidPer, @SBase, @AVivienda, @ADesplaz, @EvAbBruto, @EvDesBruto, @SBruto, @Fam*113, @INSSemp, @Mutemp, @INSSpat, @Mutpat, @RNI, @R, @ImpBr, @ImpNeto, @EvAbNeto, @EvDesNeto, @SNeto, @DiasCurro, mes, 'Si');
			set @exito = 1;
			set @salida = 'Nómina generada';
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `GenerarNomina`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerarNomina`(UidCondiciones bigint(16), DiasCurro int, out exito int(11), out salida varchar(200))
begin
	START TRANSACTION;
	set @exito = 0;
	set @SBase = (select SueldoBase from categorias where Uid = (select UidCategoria from condiciones  where Uid=UidCondiciones));
	set @ADesplaz = (select AyudaDesplazamiento from categorias where Uid = (select UidCategoria from condiciones  where Uid=UidCondiciones));
	set @AVivienda = (select AyudaVivienda from categorias where Uid = (select UidCategoria from condiciones  where Uid=UidCondiciones));
	set @UidPer = (select UidPersona from condiciones  where Uid=UidCondiciones);
	
	set @AyudaAbsoluto = (select sum(Importe) from eventualidades where UidPersona = @UidPer and Porcentual <> 1 and Tipo='ayuda');
	set @DescuentoAbsoluto = (select sum(Importe) from eventualidades where UidPersona = @UidPer and Porcentual <> 1 and Tipo='descuento');
	set @AyudaSBase = (select sum(Importe) from eventualidades where UidPersona = @UidPer and Porcentual = 1 and Tipo='ayuda' and Aplicado='SueldoBase');
	set @DescuentoSBase = (select sum(Importe) from eventualidades where UidPersona = @UidPer and Porcentual = 1 and Tipo='descuento' and Aplicado='SueldoBase');
	
	
	
	set @SBase = (@SBase * DiasCurro) / DiasCurro;
	set @SBruto = @SBase + @ADesplaz + @AVivienda;   
	
	if @AVivienda <= (@SBase * 0.6) then
		set @IAV = 0;
	else
		set @IAV = @AVivienda - (@SBase * 0.6) ;
	end if;
	
	if @ADesplaz <= (@SBase * 0.15) then
		set @IAD = 0;
	else
		set @IAD = @ADesplaz - (@SBase * 0.15) ;
	end if;
	
	set @SBrutoParcial = @SBase + @IAV + @IAD;
	set @Contravalor = @SBrutoParcial * 0.1;
	set @BrutoImponible = @SBrutoParcial + @Contravalor;
	
	if (select SSocial from condiciones where Uid=UidCondiciones) then
		if (@BrutoImponible >= 15000) then
			set @IMSS = 3900;
			set @IMSSPatronal = 5850;
		else
			set @IMSS = @BrutoImponible * 2.6;
			set @IMSSPatronal = @BrutoImponible * 3.9;
		end if;
	else
			set @IMSS = 0;
	end if;
	
	if (select SeguroMedico from condiciones where Uid=UidCondiciones) = 1 then
		set @SeguroMedico = @SBase * 0.04;
		set @SeguroMedicoPatronal = @SBase * 0.06;
	else
		set @SeguroMedico = 0;
	end if;
	 
	set @RNetoImponible = round(@BrutoImponible - @IMSS - @SeguroMedico - @IAD, -2);
	
	
	
	if @RNetoImponible >= 40.000 then
		set @R= @RNetoImponible - 40.000;
	else
		set @R = 0;
	end if;
	
	
	set @I = @R * (select Coeficiente from baremomesoficial where Inferior < @RNetoImponible and Superior > @RNetoImponible) - (select sustraendo from baremomesoficial where Inferior < @RNetoImponible and Superior > @RNetoImponible);
	
	set @Mujer = (select Esposa from condiciones where Uid=UidCondiciones);
	set @NumHijos = (select Hijos from condiciones where Uid=UidCondiciones);
	if @Mujer is null then
		set @Mujer = 0;
	end if;
	if @NumHijos is null then
		set @NumHijos = 0;
	end if;
	set @AFamilia = (@Mujer * 300) - (@NumHijos *150);
	set @H = @I - @AFamilia;
	
	set @Sueldo = @SBruto - @H;
	
	
	insert into nominas
	(UidPersona, SueldoBruto, SueldoBase, AyudaVivienda, AyudaDesplazamiento, AyudaFamilia, SeguridadSocial, Mutualidad, IPR, DiasTrabajados, FechaEmision, SueldoFinal) values
	(@UidPer, @SBruto, @SBase,  @AVivienda, @ADesplaz, @AFamilia, @IMSS, @SeguroMedico, @I, DiasCurro, now(), @Sueldo);
	set @exito = 1;
	set @salida = 'Se ha creado la nómina';
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida, @IMSSPatronal,@SeguroMedicoPatronal, @IAV, @IAD,@R;
end$$

DROP PROCEDURE IF EXISTS `InformesClases`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InformesClases`(cla bigint(16), tipo varchar(20), fechini date, fechfin date, out exito int(11), out seleccion varchar(200))
begin
	set @exito = 1;
	set @seleccion = ' ';
	if fechini is null and fechfin is null then
		if (curdate() <= concat(year(curdate()), '-09-30')) then
			set @seleccion = concat(@seleccion, "and '", concat(year(curdate())-1,'-10-01'), "' <= Fecha and Fecha <= '", concat(year(curdate()), '-09-30'), "'");
		else
			set @seleccion = concat(@seleccion, "and '", concat(year(curdate()), '-10-01'), "' <= Fecha and Fecha <= '", concat(year(curdate())+1, '-09-30'), "'");
		end if;
	else
		if fechini is null and fechfin is not null then
			set @seleccion = concat(@seleccion, ' and Fecha <= "', fechfin, '"');
		else
			if fechini is not null and fechfin is null then
				set @seleccion = concat(@seleccion, ' and "', fechini, '" <= Fecha');
			else
				set @seleccion = concat(@seleccion, ' and "', fechini, '" <= Fecha and Fecha <= "', fechfin, '"');
			end if;
		end if;
	end if;
	if tipo = "Activo" then
		set @seleccion = concat('select sum(Debe) as sumDebe, sum(Haber) as sumHaber from apuntes where Activo = 1 and Cuenta in (select Uid from cuentascontables where UidClase = ', cla, ' and TipoCuenta = "Activo") and (Debe <> 0 or Haber <> 0)', @seleccion);
	else
		if tipo = "Pasivo" then
			set @seleccion = concat('select sum(Debe) as sumDebe, sum(Haber) as sumHaber from apuntes where  Activo = 1 and Cuenta in (select Uid from cuentascontables where UidClase = ', cla, ' and TipoCuenta = "Pasivo") and (Debe <> 0 or Haber <> 0)', @seleccion);
		else
			if tipo = "Ingresos" then
				set @seleccion = concat('select sum(Debe) as sumDebe, sum(Haber) as sumHaber from apuntes where  Activo = 1 and Cuenta in (select Uid from cuentascontables where UidClase = ', cla, ' and TipoCuenta = "Ingresos") and (Debe <> 0 or Haber <> 0)', @seleccion);
			else
				if tipo = "Gastos" then
					set @seleccion = concat('select sum(Debe) as sumDebe, sum(Haber) as sumHaber from apuntes where  Activo = 1 and Cuenta in (select Uid from cuentascontables where UidClase = ', cla, ' and TipoCuenta = "Gastos") and (Debe <> 0 or Haber <> 0)', @seleccion);
				else
					if tipo = "Gestion" then
						set @seleccioin = concat('select sum(Debe) as sumDebe, sum(Haber) as sumHaber from apuntes where Activo = 1 and Cuenta in (select Uid from cuentascontables where UidClase = ', cla, ' and TipoCuenta = "Gestion") and (Debe <> 0 or Haber <> 0)', @seleccion);
					else
						set @exito = 0;
						set @seleccion = 'select * from apuntes where false';
					end if;
				end if;
			end if;
		end if;
	end if;
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `InformesCuentas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InformesCuentas`(cuen bigint(16), tipo varchar(20), fechini date, fechfin date, tod varchar(4), out exito int(11), out seleccion varchar(200))
begin
	set @exito = 1;
	set @seleccion = ' ';
	if fechini is null and fechfin is null then
		if (curdate() <= concat(year(curdate()), '-09-30')) then
			set @seleccion = concat(@seleccion, "and '", concat(year(curdate())-1,'-10-01'), "' <= Fecha and Fecha <= '", concat(year(curdate()), '-09-30'), "'");
		else
			set @seleccion = concat(@seleccion, "and '", concat(year(curdate()), '-10-01'), "' <= Fecha and Fecha <= '", concat(year(curdate())+1, '-09-30'), "'");
		end if;
	else
		if fechini is null and fechfin is not null then
			set @seleccion = concat(@seleccion, ' and Fecha <= "', fechfin, '"');
		else
			if fechini is not null and fechfin is null then
				set @seleccion = concat(@seleccion, ' and "', fechini, '" <= Fecha');
			else
				set @seleccion = concat(@seleccion, ' and "', fechini, '" <= Fecha and Fecha <= "', fechfin, '"');
			end if;
		end if;
	end if;
	if tod = "Si" then
		if tipo = "Activo" then
			set @seleccion = concat('select sum(Debe) as sumDebe, sum(Haber) as sumHaber from apuntes where  Activo = 1 and Cuenta in (select Uid from cuentascontables where instr((select NumeroCuenta from cuentascontables where Uid = ', cuen, '), mid(NumeroCuenta,1,2)) <> 0 and TipoCuenta = "Activo") and (Debe <> 0 or Haber <> 0)', @seleccion);
		else
			if tipo = "Pasivo" then
				set @seleccion = concat('select sum(Debe) as sumDebe, sum(Haber) as sumHaber from apuntes where  Activo = 1 and Cuenta in (select Uid from cuentascontables where instr((select NumeroCuenta from cuentascontables where Uid = ', cuen, '), mid(NumeroCuenta,1,2)) <> 0 and TipoCuenta = "Pasivo") and (Debe <> 0 or Haber <> 0)', @seleccion);
			else
				if tipo = "Ingresos" then
					set @seleccion = concat('select sum(Debe) as sumDebe, sum(Haber) as sumHaber from apuntes where  Activo = 1 and Cuenta in (select Uid from cuentascontables where instr((select NumeroCuenta from cuentascontables where Uid = ', cuen, '), mid(NumeroCuenta,1,2)) <> 0 and TipoCuenta = "Ingresos") and (Debe <> 0 or Haber <> 0)', @seleccion);
				else
					if tipo = "Gastos" then
						set @seleccion = concat('select sum(Debe) as sumDebe, sum(Haber) as sumHaber from apuntes where  Activo = 1 and Cuenta in (select Uid from cuentascontables where instr((select NumeroCuenta from cuentascontables where Uid = ', cuen, '), mid(NumeroCuenta,1,2)) <> 0 and TipoCuenta = "Gastos") and (Debe <> 0 or Haber <> 0)', @seleccion);
					else
						if tipo = "Gestion" then
							set @seleccion =concat('select sum(Debe) as sumDebe, sum(Haber) as sumHaber from apuntes where Activo = 1 and Cuenta in (select Uid from cuentascontables where instr((select NumeroCuenta from cuentascontables where Uid = ', cuen, '), mid(NumeroCuenta, 1, 2)) <> 0 and TipoCuenta = "Gestion") and (Debe <> 0 or Haber <> 0)', @seleccion);
						else
							set @exito = 0;
							set @seleccion = 'select * from apuntes where false';
						end if;
					end if;
				end if;
			end if;
		end if;
	else
		if tipo = "Activo" then
			set @seleccion = concat('select sum(Debe) as sumDebe, sum(Haber) as sumHaber from apuntes where  Activo = 1 and Cuenta = ', cuen, ' and (Debe <> 0 or Haber <> 0)', @seleccion);
		else
			if tipo = "Pasivo" then
				set @seleccion = concat('select sum(Debe) as sumDebe, sum(Haber) as sumHaber from apuntes where  Activo = 1 and Cuenta =', cuen, ' and (Debe <> 0 or Haber <> 0)', @seleccion);
			else
				if tipo = "Ingresos" then
					set @seleccion = concat('select sum(Debe) as sumDebe, sum(Haber) as sumHaber from apuntes where  Activo = 1 and Cuenta = ', cuen, ' and (Debe <> 0 or Haber <> 0)', @seleccion);
				else
					if tipo = "Gastos" then
						set @seleccion = concat('select sum(Debe) as sumDebe, sum(Haber) as sumHaber from apuntes where  Activo = 1 and Cuenta = ', cuen, ' and (Debe <> 0 or Haber <> 0)', @seleccion);
					else
						if tipo = "Gestion" then
							set @seleccion =concat('select sum(Debe) as sumDebe, sum(Haber) as sumHaber from apuntes where Activo = 1 and Cuenta = ', cuen, ' and (Debe <> 0 or Haber <> 0)', @seleccion);
						else
							set @exito = 0;
							set @seleccion = 'select * from apuntes where false';
						end if;
					end if;
				end if;
			end if;
		end if;
	end if;
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `InformesSubcuentas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InformesSubcuentas`(sub bigint(16), tipo varchar(20), fechini date, fechfin date, out exito int(11), out seleccion varchar(200))
begin
	set @exito = 1;
	set @seleccion = ' ';
	if fechini is null and fechfin is null then
		if (curdate() <= concat(year(curdate()), '-09-30')) then
			set @seleccion = concat(@seleccion, "and '", concat(year(curdate())-1,'-10-01'), "' <= Fecha and Fecha <= '", concat(year(curdate()), '-09-30'), "'");
		else
			set @seleccion = concat(@seleccion, "and '", concat(year(curdate()), '-10-01'), "' <= Fecha and Fecha <= '", concat(year(curdate())+1, '-09-30'), "'");
		end if;
	else
		if fechini is null and fechfin is not null then
			set @seleccion = concat(@seleccion, ' and Fecha <= "', fechfin, '"');
		else
			if fechini is not null and fechfin is null then
				set @seleccion = concat(@seleccion, ' and "', fechini, '" <= Fecha');
			else
				set @seleccion = concat(@seleccion, ' and "', fechini, '" <= Fecha and Fecha <= "', fechfin, '"');
			end if;
		end if;
	end if;
	if tipo = "Activo" then
		set @seleccion = concat('select sum(apuntes.Debe) as sumDebe, sum(apuntes.Haber) as sumHaber from apuntes, cuentascontables where  apuntes.Activo = 1 and Cuenta = ', sub, ' and (apuntes.Debe <> 0 or apuntes.Haber <> 0) and cuentascontables.Uid = ', sub, ' and cuentascontables.TipoCuenta = "Activo"',@seleccion);
	else
		if tipo = "Pasivo" then
			set @seleccion = concat('select sum(apuntes.Debe) as sumDebe, sum(apuntes.Haber) as sumHaber from apuntes, cuentascontables where  apuntes.Activo = 1 and Cuenta = ', sub, ' and (apuntes.Debe <> 0 or apuntes.Haber <> 0) and cuentascontables.Uid = ', sub, ' and cuentascontables.TipoCuenta = "Pasivo"',@seleccion);
		else
			if tipo = "Ingresos" then
				set @seleccion = concat('select sum(apuntes.Debe) as sumDebe, sum(apuntes.Haber) as sumHaber from apuntes, cuentascontables where  apuntes.Activo = 1 and Cuenta = ', sub, ' and (apuntes.Debe <> 0 or apuntes.Haber <> 0) and cuentascontables.Uid = ', sub, ' and cuentascontables.TipoCuenta = "Ingresos"',@seleccion);
			else
				if tipo = "Gastos" then
					set @seleccion = concat('select sum(apuntes.Debe) as sumDebe, sum(apuntes.Haber) as sumHaber from apuntes, cuentascontables where  apuntes.Activo = 1 and Cuenta = ', sub, ' and (apuntes.Debe <> 0 or apuntes.Haber <> 0) and  cuentascontables.Uid = ', sub, ' and cuentascontables.TipoCuenta = "Gastos"',@seleccion);
				else
					if tipo = "Gestion" then
						set @seleccion = concat('select sum(apuntes.Debe) as sumDebe, sum(apuntes.Haber) as sumHaber from apuntes, cuentascontables where apuntes.Activo = 1 and Cuenta = ', sub, ' and (apuntes.Debe <> 0 and apuntes.Haber <> 0) and cuentascontables.Uid = ', sub, ' and cuentascontables.TipoCuenta = "Gestion"', @seleccion);
					else
						set @exito = 0;
						set @seleccion = 'select * from apuntes where false';
					end if;
				end if;
			end if;
		end if;
	end if;
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `MayorDeCuenta`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MayorDeCuenta`(Id bigint(16), fechini varchar(10), fechfin varchar(10), borr enum('Si','No'), out exito int(11), out seleccion varchar (600))
begin
	set @exito = 1;
	set @criterio = concat_ws(' ', 'Cuenta = cuentascontables.Uid and cuentascontables.Activo = 1 and movimientos.Uid = UidMovimiento', concat(' and Cuenta = ', Id));
	if borr is not null then
		set  @criterio = concat(@criterio, " and movimientos.Borrador = '", borr, "'");
	end if;
	set @seleccion = concat('select apuntes.Uid, movimientos.Borrador, movimientos.Numero, Fecha, Referencia, Concepto, Moneda, apuntes.Debe, apuntes.Haber from apuntes, movimientos, cuentascontables where ', @criterio);
	if fechini is null and fechfin is null then
		if (curdate() <= concat(year(curdate()), '-09-30')) then
			set @seleccion = concat(@seleccion, " and '", concat(year(curdate())-1,'-10-01'), "' <= Fecha and Fecha <= '", concat(year(curdate()), '-09-30'), "'");
		else
			set @seleccion = concat(@seleccion, " and '", concat(year(curdate()), '-10-01'), "' <= Fecha and Fecha <= '", concat(year(curdate())+1, '-09-30'), "'");
		end if;
	else
		if fechini is null and fechfin is not null then
			set @seleccion = concat(@seleccion, ' and Fecha <= "', fechfin, '"');
		else
			if fechini is not null and fechfin is null then
				set @seleccion = concat(@seleccion, ' and "', fechini, '" <= Fecha');
			else
				set @seleccion = concat(@seleccion, ' and "', fechini, '" <= Fecha and Fecha <= "', fechfin, '"');
			end if;
		end if;
	end if;
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `MayorDeCuentaTotal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MayorDeCuentaTotal`(Id bigint(16), fechini varchar(10), fechfin varchar(10), borr enum('Si','No'), out exito int(11), out seleccion varchar(500))
begin
	set @exito = 1;
	set @criterio = concat_ws(' ', 'Cuenta = cuentascontables.Uid and cuentascontables.Activo = 1 and movimientos.Uid = UidMovimiento and clases.Uid = cuentascontables.UidClase', concat('and Cuenta = ', Id));
	if borr is not null then
		set @criterio =  concat(@criterio, " and movimientos.Borrador = '", borr,"'");
	end if;
	set @seleccion = concat('select sum(apuntes.Debe) as TotalDebe, sum(apuntes.Haber) as TotalHaber, clases.NumeroClase from apuntes, movimientos, cuentascontables, clases where ', @criterio);
	if fechini is null and fechfin is null then
		if (curdate() <= concat(year(curdate()), '-09-30')) then
			set @seleccion = concat(@seleccion, " and '", concat(year(curdate())-1,'-10-01'), "' <= Fecha and Fecha <= '", concat(year(curdate()), '-09-30'), "'");
		else
			set @seleccion = concat(@seleccion, " and '", concat(year(curdate()), '-10-01'), "' <= Fecha and Fecha <= '", concat(year(curdate())+1, '-09-30'), "'");
		end if;
	else
		if fechini is null and fechfin is not null then
			set @seleccion = concat(@seleccion, ' and Fecha <= "', fechfin, '"');
		else
			if fechini is not null and fechfin is null then
				set @seleccion = concat(@seleccion, ' and "', fechini, '" <= Fecha');
			else
				set @seleccion = concat(@seleccion, ' and "', fechini, '" <= Fecha and Fecha <= "', fechfin, '"');
			end if;
		end if;
	end if;
	set @seleccion = concat(@seleccion, 'group by NumeroClase');
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDeAmortizacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeAmortizacion`(UidAmor bigint(16), UidBienes bigint(16), FCompra date, Num varchar(10), Concept varchar(40), Orig varchar(40), Price float(11), OUT exito int(11), OUT salida varchar(400))
BEGIN
	START TRANSACTION;
	set @exito = 0;
	if (select Acumulado from amortizaciones where Uid = UidAmor) > 0 then
		update amortizaciones set
			Concepto = Concept
		where
			Uid = UidAmor;
		set @exito = 1;
		set @salida = 'Sólo se permite modificar el Concepto debido a que ha pasado la primera amortización';
	else
		update amortizaciones set
			UidClasesBienes = UidBienes,
			FechaCompra = FCompra,
			Numero = Num,
			Concepto = Concept,
			Origen = Orig,
			Precio = Price,
			FechaModificacion = now()
		where
			Uid = UidAmor;
		set @salida = 'Se ha modificado el registro';
		set @exito = 1;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `ModificacionDeApunte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeApunte`(Id bigint(16), idmov bigint(16), fech varchar(10), mone varchar(10), idcuen bigint(16), conce varchar(100), deb float, hab float, doc varchar(20), out exito int(11), out salida varchar(100))
begin
	START TRANSACTION;
	if 'No' = (select Borrador from movimientos where movimientos.Uid in (select UidMovimiento from apuntes where apuntes.Uid = Id)) then
		set @exito = 0;
		set @salida = 'El movimiento no está en modo Borrador, no se puede modificar';
	else
		if (concat(idmov, fech, mone, idcuen, conce) is null) or (deb is null and hab is null) then
			set @exito = 0;
			set @salida = 'Campos obligatorios vacíos';
		else
			if deb is null then
				set deb = 0;
			end if;
			if hab is null then
				set hab = 0;
			end if;
			set @debant = (select Debe from apuntes where Uid = Id);
			set @habant = (select Haber from apuntes where Uid = Id);
			set @cuenant =(select Cuenta from apuntes where Uid = Id);
			set @totd = (select Debe from cuentascontables where Uid = @cuenant);
			set @toth = (select Haber from cuentascontables where Uid = @cuenant);
			update cuentascontables set
				Debe = @totd - @debant,
				Haber = @toth - @habant
			where Uid = @cuenant;
			set @totd = (select Debe from cuentascontables where Uid = idcuen);
			set @toth = (select Haber from cuentascontables where Uid = idcuen);
			update cuentascontables set
				Debe = @totd + deb,
				Haber = @toth + hab
			where Uid = idcuen;
			set @toth = (select TotalHaber from movimientos where Uid = idmov);
			set @totd = (select TotalDebe from movimientos where Uid = idmov);
			update movimientos set
				TotalDebe = @totd - @debant + deb,
				TotalHaber = @toth - @habant + hab
			where Uid = idmov;
			update apuntes set
				Fecha = fech,
				Moneda = mone,
				Cuenta = idcuen,
				Concepto = conce,
				Debe = deb,
				Haber = hab,
				Referencia = doc,
				FechaModificacion = now()
			where Uid = Id;
			set @exito = 1;
			set @salida = 'Se ha modificado el registro';
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDeCategorias`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeCategorias`(Id bigint(16), Tip varchar(100), SBase varchar(10), AVivienda varchar(10), ADesplazamiento varchar(10), out exito int(11), out salida varchar(200))
BEGIN
	START TRANSACTION;
	if concat(Tip, SBase, Avivienda, ADesplazamiento) is null then
		set @exito = 0;
		set @salida ='Todos los campos son obligatorios';
	else
		update categorias set
			Categoria = Tip,
			SueldoBase = SBase,
			Vivienda = AVivienda,
			Desplazamiento = ADesplazamiento,
			FechaModificacion = now()
		where Uid = Id;
		set @exito = 1;
		set @salida = 'Se ha modificado el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `ModificacionDeClase`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeClase`(Id bigint(16), nume varchar(5), nomb varchar(100), tipo enum('Situacion','Explotacion','Gestion'), out exito int(11), out salida varchar(100))
begin
	START TRANSACTION;
	if isnull(concat(nume, nomb,tipo)) then
		set @exito = 0;
		set @salida = 'Campos obligatorios vacíos';
	else
		if ((select count(*) from clases where NumeroClase = nume) > 0) and ((select count(*) from clases where NombreClase = nomb) > 0) then
			if (select TipoClase from clases where NumeroClase = nume) = tipo then
				set @exito = 0;
				set @salida = 'La clase ya existe';
			else
				if (cast(nume as unsigned)) then
					update clases set
						NumeroClase = nume,
						NombreClase = nomb,
						TipoClase = tipo
					where Uid = Id;
					set @exito = 1;
					set @salida = 'Se ha modificado el registro';
				else
					set @exito = 0;
					set @salida = 'Valor no válido';
				end if;
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDeClaseBien`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeClaseBien`(Id bigint(16), obj varchar(100), porcen float, out exito int(11), out salida varchar(50))
begin
	START TRANSACTION;
	if concat(obj,porcen) is not null then
		if (select count(*) from clasesbienes where Tipo = obj and Uid <> Id) = 0 then
			update clasesbienes set Tipo = obj, Porcentaje = porcen where Uid = Id;
			set @exito = 1;
			set @salida = 'Se ha creado el registro';
		else
			set @exito = 0;
			set @salida = 'Ya existe el registro';
		end if;
	else
		set @exito = 0;
		set @salida = 'Campos obligatorios vacíos';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDeCondicion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeCondicion`(Id bigint(16), UidPer bigint(16), Fechini varchar(10), Fechfin varchar(10), UidCat bigint(16), ssocem enum('Si','No'), ssocpa enum('Si','No'), segmedem enum('Si','No'), segmedpa enum('Si','No'), fam varchar(1), diastrab int(11), out exito int(11), out salida varchar(50))
begin
	START TRANSACTION;
	if concat(UidPer, Fechini, Fechfin, diastrab, UidCat, ssocem, ssocpa, segmedem, segmedpa) is null then
		set @exito = 0;
		set @salida ='Campos obligatorios vacíos';
	else
		if (select count(*) from categorias where Uid = UidCat) = 0 then
			set @exito = 0;
			set @salida = 'No existe la categoría';
		else
			if (Fechfin is not null) then
				if (Fechfin < Fechini) then
					set @exito = 0;
					set @salida = 'La fecha de fin no puede ser anterior a la fecha de inicio';
				else
					set @exito = 1;
					set @salida = 'Se ha modificado el registro';
				end if;
			else
				set @exito = 0;
				set @salida = 'Campos obligatorios vacíos';
			end if;
		end if;
	end if;
	if @exito = 1 then
		update condiciones set
			UidPersona = UidPer,
			FechaInicio = Fechini,
			FechaFin = Fechfin,
			DiasTrabajados = diastrab,
			UidCategoria = UidCat,
			SSocial = ssocem,
			SSocialPatr = ssocpa,
			SeguroMedico = segmedem,
			SeguroMedicoPatr = segmedpa,
			Familia = fam,
			FechaModificacion = now()
		where Uid = Id;
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;

end$$

DROP PROCEDURE IF EXISTS `ModificacionDeCuentaBancaria`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeCuentaBancaria`(Id bigint(16), cuen varchar(40), ban varchar(40), pers bigint(16), tip enum('Persona','Organizacion'), out exito int(11), out salida varchar(50))
begin
	START TRANSACTION;
	if isnull(concat(Id, cuen, ban, pers, tip)) then
		set @exito = 0;
		set @salida = 'Campos obligatorios vacíos';
	else
		if ((select count(*) from cuentasbancarias where Cuenta = cuen and Activo = 1) > 1) and ((select count(*) from cuentasbancarias where Banco = ban and Activo = 1) > 1) then
			set @exito = 0;
			set @salida = 'La cuenta bancaria ya existe';
		else
			if (select count(*) from cuentasbancarias where Activo = 1 and UidTercero = pers and TipoTercero = tip) > 1 then
				set @exito = 0;
				set @salida = 'Ya existe una cuenta bancaria para este tercero';
			else
				update cuentasbancarias set
					Cuenta = cuen,
				        Banco = ban,
					UidTercero = pers,
					TipoTercero = tip,
					FechaModificacion = now()
				where Uid = Id;
				set @exito = 1;
				set @salida = 'Se ha modificado el registro';
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDeCuentaContable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeCuentaContable`(Id bigint(16), clase bigint(16), IdTercero bigint(16), numcuen varchar(10), nomcuenta varchar(100), IdPadre bigint(16), deb float, hab float, tiptercero enum ('Persona','Organizacion','Ninguno'), tipo enum('Activo','Pasivo','Ingresos','Gastos','Explotacion'), out exito int(11), out salida varchar(50))
begin
	START TRANSACTION;
	if isnull(concat(Id, clase, numcuen, nomcuenta, deb, hab, tiptercero)) or (tiptercero <> "Ninguno" and isnull(IdTercero)) then
		set @exito = 0;
		set @salida = 'Campos obligatorios vacíos';
	else
		set @antclase = (select UidClase from cuentascontables where Uid = Id and Activo = 1);
		set @anttercero = (select UidTercero from cuentascontables where Uid = Id and Activo = 1);
		set @antnumero = (select NumeroCuenta from cuentascontables where Uid = Id and Activo = 1);
		set @antpadre = (select Padre from cuentascontables where Uid = Id and Activo = 1);
		set @antdebe = (select Debe from cuentascontables where Uid = Id and Activo = 1);
		set @anthaber = (select Haber from cuentascontables where Uid = Id and Activo = 1);
		set @anttipter = (select TipoTercero from cuentascontables where Uid = Id and Activo = 1);
		if (@antclase <> clase) or (@anttercero <> IdTercero) or (@antnumero <> numcuen) or (@antpadre <> IdPadre) or (@antdebe <> deb) or (@anthaber <> hab) or (@anttipter <> tiptercero) then
			set @exito = 0;
			set @salida = 'Sólo puede modificar el Nombre y el Tipo';
		else
			update cuentascontables
				set NombreCuenta = nomcuenta,
				TipoCuenta = tipo,
				FechaModificacion = now()
			where Uid = Id and Activo = 1;
			set @exito = 1;
			set @salida = 'Se ha modificado el registro';
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDeEventualidad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeEventualidad`(Id bigint(16), UidPer bigint(16), Concept varchar(100), Import float, Aplic enum('Bruto','Neto'), Tip enum('Abono','Descuento'), Fechini varchar(10), Fechfin varchar(10), out exito int(11), out salida varchar(200))
BEGIN
	START TRANSACTION;
	if concat(UidPer, Concept, Import, Aplic, Tip, Fechini,Fechfin) is null then
		set @exito = 0;
		set @salida ='Campos obligatorios vacíos';
	else
		if (Select count(1) from eventualidades where Uid = Id)=0 then
			set @exito = 0;
			set @salida = 'No existe el registro';
		else
			if (Fechfin is not null) then
				if (Fechfin < Fechini) then
					set @exito = 0;
					set @salida = 'La fecha de fin no puede ser anterior a la fecha de inicio';
				else
					set @exito = 1;
				end if;
			else
				set @exito = 0;
				set @salida = 'Campos obligatorios vacíos';
			end if;
		end if;
	end if;
	if @exito = 1 then
		update eventualidades set
			UidPersona= UidPer,
			Concepto = Concept,
			Porcentual =  0,
			Importe = abs(Import),
			Limite = 0,
			Aplicado = Aplic,
			IPR = 0,
			Tipo = Tip,
			FechaInicio = Fechini,
			FechaFin = Fechfin,
			FechaModificacion = now()
		where Uid = Id;
		set @salida = 'Se ha modificado el registro';
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `ModificacionDeMovimiento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeMovimiento`(Id bigint(16), nume varchar(11), borr enum('Si','No'), out exito int(11), out salida varchar(100))
begin
	START TRANSACTION;
	if 'No' = (select Borrador from movimientos where Uid = Id) then
		set @exito = 0;
		set @salida = 'El movimiento no está en modo Borrador, no se puede modificar';
	else
		if nume is null then
			set @exito = 0;
			set @salida = 'Campos obligatorios vacíos';
		else
			if (select nume in (select Numero from movimientos where (Activo = 1 and Uid <> Id))) then
				set @exito = 0;
				set @salida = 'El número de movimiento ya existe';
			else
				update movimientos set
					Numero = nume,
					Borrador = borr,
					FechaModificacion =now()
				where Uid = Id;
				set @exito = 1;
				set @salida = 'Se ha modificado el registro';
			end if;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDeOrganizacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeOrganizacion`(Id bigint(16), Nombr varchar(50), Apellid varchar(50), NumId varchar(20), Dir varchar(200), Distr varchar(100), Loca int, Prov int, Pai int, out exito int(11), out salida varchar(400))
BEGIN
	START TRANSACTION;
	if isnull(concat(Id,Nombr,NumId, Dir, Loca, Prov, Pai)) then
		set @exito = 0;
		set @salida = ValidarNullModificacionOrganizacion(Id, Nombr, NumId, Dir, Loca, Prov, Pai);
	else
		if ((select NumIdentificacion from organizaciones where  Uid = Id) <> NumId)  and  ((select count(*) from organizaciones where NumIdentificacion = NumId) > 0) then
				set @salida = 'Número de identificación ya existente';
				set @exito = 0;
		else
			update organizaciones set
				Nombre = Nombr,
				Apellidos = Apellid,
				NumIdentificacion = NumId,
				Direccion = Dir,
				Distrito = Distr,
				Localidad = Loca,
				Provincia = Prov,
				Pais = Pai,
				FechaModificacion = now()
			where Uid = Id;
			set @salida = 'Se ha modificado el registro';
			set @exito = 1;
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
END$$

DROP PROCEDURE IF EXISTS `ModificacionDeTipoMovimiento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeTipoMovimiento`(Id bigint(16), mov varchar(100), out exito int(11), out salida varchar(100))
begin
	START TRANSACTION;
	if isnull(concat(Id,mov)) then
		set @exito = 0;
		set @salida = 'Campos obligatorios vacíos';
	else
		if (select Movimiento from tiposmovimientos where Clave = Id) <> mov and (select count(*) from tiposmovimientos where Movimiento = mov) > 0 then
			set @exito = 0;
			set @salida = 'El tipo de movimiento ya existe';
		else
			update tiposmovimientos set
				Movimiento = mov
			where Clave = Id;
			set @exito = 1;
			set @salida = 'Se ha modificado el registro';
		end if;
	end if;
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `ModificacionDeUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificacionDeUsuario`(Id bigint, usuar varchar(45), pass varchar(45), person bigint, tipousuar enum ('Contable','Administrativo','TEDECO','Profesor','Decano','Bibliotecario'), out exito int(11), out salida varchar(100))
BEGIN
	START TRANSACTION;
	if (usuar is null) or (pass is null) or (person is null) or (tipousuar is null) or (Id is null) then
		set @exito = 0;
		set @salida = ValidarNullModificacionUsuario (Id,usuar, pass, person, tipousuar);
	else
		set @per = (select Uid from kumenya_matriculacion.personas where Uid = person and Activo = 1);
		if (@per is null) then
			set @salida = 'No existe la persona seleccionada';
			set @exito = 0;
		else
			if (select count(*) from usuarios where TipoUsuario = tipousuar and Uid != Id and Usuario = usuar and Activo = 1) > 0 then
				set @exito = 0;
				set @salida = 'Ya existe el usuario y rol seleccionados';
			else
				update usuarios
					set Uid = Id,
					Usuario = usuar,
					Contrasena = pass,
					Persona = person,
					TipoUsuario = tipousuar,
					FechaModificacion = now()
				where Uid = Id;
				set @exito = 1;
				set @salida = 'Se ha modificado el registro';
			end if;
		end if;
	end if;
	if (@exito = 0) then
		ROLLBACK;
	else
		COMMIT;
	end if;
	select @exito, @salida;
END$$

DROP PROCEDURE IF EXISTS `MostrarCamposAltaAmortizacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarCamposAltaAmortizacion`()
BEGIN
select column_name, table_name, table_schema from information_schema.`COLUMNS`
	where table_name='amortizaciones' and column_name <>'Acumulado' and column_name <> 'Anual' and column_name <> 'VNC';
END$$

DROP PROCEDURE IF EXISTS `MostrarCamposAltaCondicion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarCamposAltaCondicion`()
BEGIN
select column_name, table_name, table_schema from information_schema.`COLUMNS`
	where
(table_name='condiciones' and column_name <>'UidPersona' and column_name <>'UidCategoria' and column_name <> 'Activo' and column_name <> 'FechaCreacion' and column_name <> 'FechaModificacion' and column_name <> 'FechaBaja')
        or (table_name='categorias' and column_name in ('Uid', 'Categoria'))
        or (table_name='personas' and column_name in ('Uid', 'Nombre', 'Apellidos','TipoPersona', 'CodigoPersona'));
END$$

DROP PROCEDURE IF EXISTS `MostrarCamposAltaCuentaContable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarCamposAltaCuentaContable`()
begin
select column_name, table_name, table_schema from information_schema.`COLUMNS`
	where (table_name='cuentascontables' and column_name <>'UidTercero' and column_name <> 'Debe' and column_name <> 'Haber' and column_name <> 'Activo' and column_name <> 'FechaCreacion' and column_name <> 'FechaModificacion' and column_name <> 'FechaBaja')
        or (table_name='organizaciones'  and
	column_name in ('Uid', 'Nombre', 'Apellidos','NumIdentificacion','Direccion','Distrito','Localidad','Provincia', 'Pais'));
end$$

DROP PROCEDURE IF EXISTS `MostrarCamposApunte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarCamposApunte`()
begin
	select column_name, table_name, table_schema from information_schema.`COLUMNS`
	where (table_name = 'movimientos' and column_name <> 'TotalDebe' and column_name <> 'TotalHaber' and column_name <> 'Activo' and column_name <> 'FechaCreacion' and column_name <> 'FechaModificacion' and column_name <> 'FechaBaja')
	or (table_name='apuntes' and column_name <> 'Cuenta' and column_name <> 'UidMovimiento' and column_name <> 'Activo' and column_name <> 'FechaCreacion' and column_name <> 'FechaModificacion' and column_name <> 'FechaBaja')
	or (table_name = 'cuentascontables' and column_name = 'NumeroCuenta')
	or (table_name = 'cuentascontables' and column_name = 'NombreCuenta')
	or (table_name = 'cuentascontables' and column_name = 'Uid');
end$$

DROP PROCEDURE IF EXISTS `MostrarCamposCuentaBancaria`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarCamposCuentaBancaria`()
begin
select column_name, table_name, table_schema from information_schema.`COLUMNS`
	where (table_name='cuentasbancarias' and column_name <>'UidTercero' and column_name <> 'Activo' and column_name <> 'FechaCreacion' and column_name <> 'FechaModificacion' and column_name <> 'FechaBaja')
        or (table_name='organizaciones'  and
	column_name in ('Uid', 'Nombre', 'Apellidos','NumIdentificacion','Direccion','Distrito','Localidad','Provincia', 'Pais'));
end$$

DROP PROCEDURE IF EXISTS `MostrarCamposCuentaContable`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarCamposCuentaContable`()
begin
select column_name, table_name, table_schema from information_schema.`COLUMNS`
	where (table_name='cuentascontables' and column_name <>'UidTercero' and column_name <> 'Activo' and column_name <> 'FechaCreacion' and column_name <> 'FechaModificacion' and column_name <> 'FechaBaja')
        or (table_name='organizaciones'  and
	column_name in ('Uid', 'Nombre', 'Apellidos','NumIdentificacion','Direccion','Distrito','Localidad','Provincia', 'Pais'));
end$$

DROP PROCEDURE IF EXISTS `MostrarCamposEventualidad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarCamposEventualidad`()
begin
select column_name, table_name, table_schema from information_schema.`COLUMNS`
	where (table_name='eventualidades' and column_name <>'UidPersona' and column_name <> 'IPR' and column_name <> 'Porcentual' and column_name <> 'Limite' and column_name <> 'Activo' and column_name <> 'FechaCreacion' and column_name <> 'FechaModificacion'
			 and column_name <> 'FechaBaja' )
	 or (table_name='personas'  and column_name in ('Uid', 'Nombre', 'Apellidos','TipoPersona','Titulo','Estado','CodigoPersona','Codigo'));
end$$

DROP PROCEDURE IF EXISTS `MostrarCamposMovimiento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarCamposMovimiento`()
begin
	select column_name, table_name, table_schema from information_schema.`COLUMNS`
	where (table_name='movimientos' and column_name <> 'TotalDebe' and column_name <> 'TotalHaber' and column_name <> 'Activo' and column_name <> 'FechaCreacion' and column_name <> 'FechaModificacion' and column_name <> 'FechaBaja');
end$$

DROP PROCEDURE IF EXISTS `MostrarCamposMovimientos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarCamposMovimientos`()
begin
	select column_name, table_name, table_schema from information_schema.`COLUMNS`
	where (table_name='movimientos' and column_name <> 'Activo' and column_name <> 'FechaCreacion' and column_name <> 'FechaModificacion' and column_name <> 'FechaBaja');
end$$

DROP PROCEDURE IF EXISTS `MostrarCamposOrganizaciones`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarCamposOrganizaciones`()
BEGIN
select column_name, table_name, table_schema from information_schema.`COLUMNS`
	where
	(table_name='organizaciones' and column_name <>'Uid' and column_name <>'Activo' and column_name <>'FechaCreacion' and column_name <> 'FechaModificacion' and column_name <> 'FechaBaja');
END$$

DROP PROCEDURE IF EXISTS `MostrarCamposPagaMensual`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarCamposPagaMensual`()
begin
	select column_name, table_name, table_schema from information_schema.`COLUMNS`
	where (table_name='personas'  and column_name in ('Uid', 'Nombre', 'Apellidos','TipoPersona','CodigoPersona')) or
		(table_name = 'nominas' and column_name in ( 'SueldoBase', 'SueldoBruto', 'EvAbonoBruto',  'EvDescuentoBruto', 'FechaEmision'));
end$$

DROP PROCEDURE IF EXISTS `MostrarSanciones`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarSanciones`(Id bigint(16), out exito int(11), out seleccion varchar(1000))
begin
	START TRANSACTION;
	set @exito = 1;
	set @seleccion = concat('select kumenya_biblioteca.prestamos.Uid, kumenya_biblioteca.documentos.Titulo, kumenya_matriculacion.personas.Nombre, kumenya_matriculacion.personas.Apellidos, kumenya_biblioteca.prestamos.FechaInicio,
kumenya_biblioteca.prestamos.FechaFin, kumenya_biblioteca.prestamos.FechaDevolucion, ((datediff(kumenya_biblioteca.prestamos.FechaDevolucion, kumenya_biblioteca.prestamos.FechaFin)) * (select kumenya_biblioteca.configuracion.Valor from kumenya_biblioteca.configuracion where kumenya_biblioteca.configuracion.NombreAtributo = "SancionBiblioteca")), kumenya_biblioteca.prestamos.HaySancion from kumenya_biblioteca.prestamos, kumenya_matriculacion.personas, kumenya_biblioteca.documentos
where kumenya_biblioteca.prestamos.HaySancion = "Si" and kumenya_biblioteca.prestamos.Activo = 1 and kumenya_biblioteca.prestamos.UidDocumento = kumenya_biblioteca.documentos.Uid and
kumenya_biblioteca.prestamos.UidPersona = kumenya_matriculacion.personas.Uid and kumenya_biblioteca.prestamos.UidPersona = ', Id);
	select @exito, @seleccion;
	COMMIT;
end$$

DROP PROCEDURE IF EXISTS `ObtenerClases`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerClases`(out exito int(11), out seleccion varchar(100))
begin
	set @exito = 1;
	set @seleccion = 'select Uid, NumeroClase, NombreClase from clases where NumeroClase <= 5 and TipoClase = "Situacion" order by NumeroClase';
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `ObtenerCuentas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerCuentas`(Id bigint(16), out exito int(11), out seleccion varchar(200))
begin
	set @exito = 1;
	set @seleccion = concat('select Uid, TipoTercero from cuentascontables where UidClase = ', Id, ' and Padre is null and Activo = 1 order by NumeroCuenta');
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `ObtenerSubcuentas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerSubcuentas`(Id bigint(16), out exito int(11), out seleccion varchar(200))
begin
	set @exito = 1;
	set @nom = (select NumeroCuenta from cuentascontables where Uid = Id);
	set @seleccion = concat('select Uid,TipoTercero from cuentascontables where mid(NumeroCuenta,1,2) = ', @nom, ' and Uid <> ', Id, ' and Activo = 1 order by Length(NumeroCuenta), NumeroCuenta');
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `PagarSancion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PagarSancion`(Id bigint(16), cant float, out exito int(11), out salida varchar(80))
begin
	START TRANSACTION;
	set @exito = 0;
	
	update kumenya_biblioteca.prestamos set
		kumenya_biblioteca.prestamos.HaySancion = 'No',
		kumenya_biblioteca.prestamos.FechaModificacion = now(),
		kumenya_biblioteca.prestamos.Activo = 0
	where kumenya_biblioteca.prestamos.Uid = Id and kumenya_biblioteca.prestamos.HaySancion = 'Si';
	
	set @Persona = (select kumenya_biblioteca.prestamos.UidPersona from kumenya_biblioteca.prestamos where kumenya_biblioteca.prestamos.Uid = Id);
	set @cuentacaja = (select cuentascontables.Uid from cuentascontables where NumeroCuenta = '57.2');
	set @cuentapago = (select cuentascontables.Uid from cuentascontables where NumeroCuenta = '74.8');
	
	
	set @num = mid((select Valor from kumenya_biblioteca.configuracion where NombreAtributo = 'MovimientosAutomaticos'), 2) + 1;
	update kumenya_biblioteca.configuracion set
		Valor = concat( 'K', @num)
	where NombreAtributo = 'MovimientosAutomaticos';
	insert into movimientos (Numero, Borrador, TotalDebe, TotalHaber, Activo, FechaCreacion, FechaModificacion)
	values (@num, 'No', cant, cant, 1, now(), now());
	set @ulti = LAST_INSERT_ID();
	
	insert into apuntes (UidMovimiento, Fecha, Moneda, Cuenta, Concepto, Debe, Haber, Referencia, Activo, FechaCreacion, FechaModificacion)
	values (@ulti, now(), 'FBU', @cuentacaja, 'Sanción biblioteca', cant, 0, null, 1, now(), now());
	update cuentascontables set Debe = Debe + cant where Uid = @cuentacaja;
	
	insert into apuntes (UidMovimiento, Fecha, Moneda, Cuenta, Concepto, Debe, Haber, Referencia, Activo, FechaCreacion, FechaModificacion)
	values (@ulti, now(), 'FBU', @cuentapago, 'Sanción biblioteca', 0, cant, null, 1, now(), now());
	update cuentascontables set Haber =Haber + cant where Uid = @cuentapago;
	set @exito = 1;
	set @salida = 'Sanción quitada';
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito, @salida;
end$$

DROP PROCEDURE IF EXISTS `PasarADefinitivo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PasarADefinitivo`(Id bigint(16), out exito int(11), out salida varchar(100))
begin
	START TRANSACTION;
	set  @exito = 0;
	update movimientos set
		Borrador = 0,
		Activo = 1,
		FechaFinBorrador = now(),
		FechaModificacion = now()
	where Uid = Id;
	set @exito = 1;
	set @salida = 'Movimiento definitivo';
	if @exito = 1 then
		COMMIT;
	else
		ROLLBACK;
	end if;
	select @exito,@salida;
end$$

DROP PROCEDURE IF EXISTS `SubcuentasInformes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SubcuentasInformes`(Id bigint(16), tipo varchar(20), out exito int(11), out seleccion varchar(200))
begin
	set @exito = 1;
	set @nom = (select NumeroCuenta from cuentascontables where Uid = Id);
	if tipo = "Activo" then
		set @seleccion = concat('select Uid,TipoTercero from cuentascontables where mid(NumeroCuenta,1,2) = ', @nom, ' and Uid <> ', Id, ' and TipoCuenta = "Activo" and Activo = 1 order by NumeroCuenta');
	else
		if tipo = "Pasivo" then
			set @seleccion = concat('select Uid,TipoTercero from cuentascontables where mid(NumeroCuenta,1,2) = ', @nom, ' and Uid <> ', Id, ' and TipoCuenta = "Pasivo" and Activo = 1 order by NumeroCuenta');
		else
			if tipo = "Ingresos" then
				set @seleccion = concat('select Uid,TipoTercero from cuentascontables where mid(NumeroCuenta,1,2) = ', @nom, ' and Uid <> ', Id, ' and TipoCuenta = "Ingresos" and Activo = 1 order by NumeroCuenta');
			else
				if tipo = "Gastos" then
					set @seleccion = concat('select Uid,TipoTercero from cuentascontables where mid(NumeroCuenta,1,2) = ', @nom, ' and Uid <> ', Id, ' and TipoCuenta = "Gastos" and Activo = 1 order by NumeroCuenta');
				else
					if tipo = "Gestion" then
						set @seleccion = concat('select Uid, TipoTercero from cuentascontables where mid(NumeroCuenta,1,2) = ', @nom, ' and Uid <> ', Id, ' and TipoCuenta = "Gestion" and Activo = 1 order by NumeroCuenta');
					else
						set @exito = 0;
						set @seleccion = 'select * from cuentascontables where false';
					end if;
				end if;
			end if;
		end if;
	end if;
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `SumasSaldosClase`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SumasSaldosClase`(cla bigint(16), fechini date, fechfin date, out exito int(11), out seleccion varchar(400))
begin
	set @exito = 1;
	set @seleccion = ' ';
	if fechini is null and fechfin is null then
		if (curdate() <= concat(year(curdate()), '-09-30')) then
			set @seleccion = concat(@seleccion, "and '", concat(year(curdate())-1,'-10-01'), "' <= Fecha and Fecha <= '", concat(year(curdate()), '-09-30'), "'");
		else
			set @seleccion = concat(@seleccion, "and '", concat(year(curdate()), '-10-01'), "' <= Fecha and Fecha <= '", concat(year(curdate())+1, '-09-30'), "'");
		end if;
	else
		if fechini is null and fechfin is not null then
			set @seleccion = concat(@seleccion, ' and Fecha <= "', fechfin, '"');
		else
			if fechini is not null and fechfin is null then
				set @seleccion = concat(@seleccion, ' and "', fechini, '" <= Fecha');
			else
				set @seleccion = concat(@seleccion, ' and "', fechini, '" <= Fecha and Fecha <= "', fechfin, '"');
			end if;
		end if;
	end if;
	set @seleccion = concat('select sum(Debe) as sumDebe, sum(Haber) as sumHaber from apuntes where Cuenta in (select Uid from cuentascontables where UidClase = ', cla, ') and (Debe <> 0 or Haber <> 0)', @seleccion);
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `SumasSaldosCuenta`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SumasSaldosCuenta`(cuen bigint(16), fechini date, fechfin date, out exito int(11), out seleccion varchar(400))
begin
	set @exito = 1;
	set @seleccion = ' ';
	if fechini is null and fechfin is null then
		if (curdate() <= concat(year(curdate()), '-09-30')) then
			set @seleccion = concat(@seleccion, "and '", concat(year(curdate())-1,'-10-01'), "' <= Fecha and Fecha <= '", concat(year(curdate()), '-09-30'), "'");
		else
			set @seleccion = concat(@seleccion, "and '", concat(year(curdate()), '-10-01'), "' <= Fecha and Fecha <= '", concat(year(curdate())+1, '-09-30'), "'");
		end if;
	else
		if fechini is null and fechfin is not null then
			set @seleccion = concat(@seleccion, ' and Fecha <= "', fechfin, '"');
		else
			if fechini is not null and fechfin is null then
				set @seleccion = concat(@seleccion, ' and "', fechini, '" <= Fecha');
			else
				set @seleccion = concat(@seleccion, ' and "', fechini, '" <= Fecha and Fecha <= "', fechfin, '"');
			end if;
		end if;
	end if;
	set @seleccion = concat('select sum(Debe) as sumDebe, sum(Haber) as sumHaber from apuntes where Activo = 1 and Cuenta in (select Uid from cuentascontables where instr((select NumeroCuenta from cuentascontables where Uid = ', cuen, '), mid(NumeroCuenta,1,2)) <> 0 ) and (Debe <> 0 or Haber <> 0)', @seleccion);
	select @exito, @seleccion;
end$$

DROP PROCEDURE IF EXISTS `SumasSaldosSubcuenta`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SumasSaldosSubcuenta`(sub bigint(16), fechini date, fechfin date, out exito int(11), out seleccion varchar(500))
begin
	set @exito = 1;
	set @seleccion = ' ';
	if fechini is null and fechfin is null then
		if (curdate() <= concat(year(curdate()), '-09-30')) then
			set @seleccion = concat(@seleccion, "and '", concat(year(curdate())-1,'-10-01'), "' <= Fecha and Fecha <= '", concat(year(curdate()), '-09-30'), "'");
		else
			set @seleccion = concat(@seleccion, "and '", concat(year(curdate()), '-10-01'), "' <= Fecha and Fecha <= '", concat(year(curdate())+1, '-09-30'), "'");
		end if;
	else
		if fechini is null and fechfin is not null then
			set @seleccion = concat(@seleccion, ' and Fecha <= "', fechfin, '"');
		else
			if fechini is not null and fechfin is null then
				set @seleccion = concat(@seleccion, ' and "', fechini, '" <= Fecha');
			else
				set @seleccion = concat(@seleccion, ' and "', fechini, '" <= Fecha and Fecha <= "', fechfin, '"');
			end if;
		end if;
	end if;
	set @seleccion = concat('select sum(Debe) as sumDebe, sum(Haber) as sumHaber from apuntes where Activo = 1 and Cuenta = ', sub, ' and (Debe <> 0 or Haber <> 0)',@seleccion);
	select @exito, @seleccion;
end$$

--
-- Funciones
--
DROP FUNCTION IF EXISTS `NumeroPuntos`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `NumeroPuntos`(cuenta varchar(10)) RETURNS int(11)
begin
	set @cont = 0;
	set @longi = length(cuenta);
	set @aux = cuenta;
	while @longi > 0 do
		if (mid(@aux,1,1) = '.') then
			set @cont = @cont + 1;
		end if;
		set @aux = mid(@aux,2);
		set @longi = length(@aux);
	end while;
	return @cont;
end$$

DROP FUNCTION IF EXISTS `ValidarAltaApunte`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarAltaApunte`(fec varchar(10), deb float, hab float) RETURNS int(11)
begin
	if (cast(deb as unsigned)) then
		if (cast(hab as unsigned)) then
			if ValidarFecha(fec) then
				return 1;
			else
				return 0;
			end if;
		else
			return 0;
		end if;
	else
		return 0;
	end if;
end$$

DROP FUNCTION IF EXISTS `ValidarCategoria`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarCategoria`(sbase float, vivi float, despl float) RETURNS int(11)
begin
	if (cast(sbase as unsigned) and cast(vivi as unsigned) and cast(despl as unsigned)) then
		return 1;
	else
		return 0;
	end if;
end$$

DROP FUNCTION IF EXISTS `ValidarCondicion`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarCondicion`(fecini varchar(10), fecfin varchar(10), diastrab int(11), fami varchar(1)) RETURNS int(11)
begin
	if (cast(fami as unsigned)) then
		if ValidarFecha(fecini) then
			if ValidarFecha(fecfin) then
				if (cast(diastrab as unsigned)) then
					return 1;
				else
					return 0;
				end if;
			else
				return 0;
			end if;
		else
			return 0;
		end if;
	else
		return 0;
	end if;
end$$

DROP FUNCTION IF EXISTS `ValidarEventualidad`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarEventualidad`(impor varchar(10), fecini varchar(10), fecfin varchar(10)) RETURNS int(11)
begin
	if (cast(impor as unsigned)) then
		if ValidarFecha(fecini) then
			if ValidarFecha(fecfin) then
				return 1;
			else
				return 0;
			end if;
		else
			return 0;
		end if;
	else
		return 0;
	end if;
end$$

DROP FUNCTION IF EXISTS `ValidarFecha`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarFecha`(entrada varchar(10)) RETURNS int(11)
BEGIN
	set @fecha=str_to_date(entrada,'%Y-%m-%d');
	if cast(@fecha as date)  then
		return 1;
	else
		return 0;
	end if;
END$$

DROP FUNCTION IF EXISTS `ValidarInteger`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarInteger`(entrada varchar(15)) RETURNS int(11)
BEGIN
	if entrada < 0 then
		return 0;
	else
		if cast(entrada as unsigned) then
			return 1;
		else
			if (entrada = '0') then
				return 1;
			else
				return 0;
			end if;
		end if;
	end if;
END$$

DROP FUNCTION IF EXISTS `ValidarMovimiento`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarMovimiento`(imp float, anio varchar(4)) RETURNS int(11)
begin
	if anio is not null then
		if year(anio) then
			if cast(imp as unsigned) then
				return 1;
			else
				return 0;
			end if;
		else
			return 0;
		end if;
	else
		if cast(imp as unsigned) then
			return 1;
		else
			return 0;
		end if;
	end if;
end$$

DROP FUNCTION IF EXISTS `ValidarNull`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarNull`(entrada varchar(100)) RETURNS int(11)
BEGIN
	if entrada is null then
		return 0;
	else
		return 1;
	end if;
END$$

DROP FUNCTION IF EXISTS `ValidarNullAltaOrganizacion`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarNullAltaOrganizacion`(Nombr varchar(50), NumIdentificacion varchar(20), Direccion varchar(200), Poblacion varchar(100), Provincia varchar(100), Pais int) RETURNS varchar(400) CHARSET latin1
BEGIN
	set @nom = ValidarNull(Nombr);
	set @num = ValidarNull(NumIdentificacion);
	set @dir = ValidarNull(Direccion);
	set @pob = ValidarNull(Poblacion);
	set @pro = ValidarNull(Provincia);
	set @pai = ValidarNull(Pais);
	set @resul = ' ';
	set @uid = (select Uid from procedimientos where Nombre='AltaDeOrganizacion');
	if (@nom * @num * @dir * @pob * @pro * @pai  = 0) then
		set @resul ="Campos obligatorios sin informacion: ";
		if @nom = 0 then
			set @campo = (select Nombre from parametros where UidProc =@uid   and Orden = 1);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @num = 0 then
			set @campo = (select Nombre from parametros where UidProc = @uid and Orden = 3);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @dir = 0 then
			set @campo = (select Nombre from parametros where UidProc = @uid and Orden = 4);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @pob = 0 then
			set @campo = (select Nombre from parametros where UidProc = @uid and Orden = 6);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @pro = 0 then
			set @campo = (select Nombre from parametros where UidProc = @uid and Orden = 7);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
		if @pai = 0 then
			set @campo = (select Nombre from parametros where UidProc = @uid and Orden = 8);
			set @resul = concat(@resul, "'", @campo, "' ");
		end if;
	end if;
	return @resul;
END$$

DROP FUNCTION IF EXISTS `ValidarNullModificacionOrganizacion`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarNullModificacionOrganizacion`(Id bigint(16), Nombr varchar(50), NumId varchar(20), Dir varchar(200), Loca int, Prov int, Pai int) RETURNS varchar(400) CHARSET latin1
BEGIN
	set @resul = ' ';
	set @resul = ValidarNullAltaOrganizacion(Nombr,NumId,Dir,Loca,Prov,Pai);
	set @id = ValidarNull(Id);
	if @id = 0 then
		set @campo = (select Nombre from parametros where UidProc = (select Uid from procedimientos where Nombre ='ModificacionDeOrganizacion') and Orden = 1);
		if @resul <> ' ' then
			set @resul = concat(trim(@resul), " '", @campo, "'");
		else
			set @resul = trim(concat("'Campos obligatorios sin informacion: ", "'", @campo, "' "));
		end if;
	else
		set @resul = ' ';
	end if;
	return @resul;
END$$

DROP FUNCTION IF EXISTS `ValidarPaga`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidarPaga`(sbase float, sbruto float, abon float, descu float) RETURNS int(11)
begin
	if cast(sbase as unsigned) and cast(sbruto as unsigned) then
		if abon is not null then
			if cast(abon as unsigned) then
				if descu is not null then
					if cast(descu as unsigned) then
						return 1;
					else
						return 0;
					end if;
				end if;
				return 1;
			else
				return 0;
			end if;
		end if;
		return 1;
	else
		return 0;
	end if;
end$$


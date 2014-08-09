-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Máquina: localhost
-- Data de Criação: 09-Ago-2014 às 12:38
-- Versão do servidor: 5.5.38-0ubuntu0.14.04.1
-- versão do PHP: 5.5.9-1ubuntu4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de Dados: `qualidadesinalmovel`
--
CREATE DATABASE IF NOT EXISTS `qualidadesinalmovel` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `qualidadesinalmovel`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `dados_qualidade`
--

DROP TABLE IF EXISTS `dados_qualidade`;
CREATE TABLE IF NOT EXISTS `dados_qualidade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `longitude` float NOT NULL,
  `latitude` float NOT NULL,
  `operadora` varchar(8) NOT NULL,
  `intensidade_sinal` int(11) NOT NULL,
  `ligacao_interrompida` tinyint(1) NOT NULL,
  `ligacao_nao_completa` tinyint(1) NOT NULL,
  `ruido_ligacao` tinyint(1) NOT NULL,
  `sem_dados` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `erbs`
--

DROP TABLE IF EXISTS `erbs`;
CREATE TABLE IF NOT EXISTS `erbs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operadora` varchar(16) NOT NULL,
  `estacao` int(11) NOT NULL,
  `nome` varchar(128) NOT NULL,
  `uf` varchar(2) NOT NULL,
  `municipio` varchar(128) NOT NULL,
  `bairro` varchar(128) NOT NULL,
  `logradouro` varchar(256) NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `data_cadastro` date DEFAULT NULL,
  `data_prim_licenc` date DEFAULT NULL,
  `data_ult_licenc` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `estacao` (`estacao`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1066 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

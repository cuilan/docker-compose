-- 初始化 TimescaleDB 和 PostGIS 扩展
-- 这个脚本会在数据库首次启动时自动执行

-- 创建 TimescaleDB 扩展
CREATE EXTENSION IF NOT EXISTS timescaledb;

-- 创建 PostGIS 扩展
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_topology;
CREATE EXTENSION IF NOT EXISTS postgis_raster;

-- 验证扩展安装
SELECT extname, extversion 
FROM pg_extension 
WHERE extname IN ('timescaledb', 'postgis', 'postgis_topology', 'postgis_raster');

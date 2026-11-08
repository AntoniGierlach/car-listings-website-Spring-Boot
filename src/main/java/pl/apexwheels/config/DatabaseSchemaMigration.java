package pl.apexwheels.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@Component
@Order(Ordered.HIGHEST_PRECEDENCE)
public class DatabaseSchemaMigration implements CommandLineRunner {

    private static final String ADVERTISING_TABLE = "advertising";
    private static final String POWER_COLUMN = "engine_power";
    private static final String LEGACY_POWER_COLUMN = "power";

    private final JdbcTemplate jdbcTemplate;

    public DatabaseSchemaMigration(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void run(String... args) {
        jdbcTemplate.execute((Connection connection) -> {
            DatabaseMetaData metadata = connection.getMetaData();
            TableReference table = findTable(metadata, connection);
            if (table == null) {
                return null;
            }

            if (!hasColumn(metadata, table, POWER_COLUMN)) {
                String sql = "ALTER TABLE " + quoteIdentifier(metadata, table.name())
                        + " ADD COLUMN " + quoteIdentifier(metadata, POWER_COLUMN) + " INTEGER";
                try (Statement statement = connection.createStatement()) {
                    statement.executeUpdate(sql);
                }
                if (hasColumn(metadata, table, LEGACY_POWER_COLUMN)) {
                    String copySql = "UPDATE " + quoteIdentifier(metadata, table.name())
                            + " SET " + quoteIdentifier(metadata, POWER_COLUMN)
                            + " = " + quoteIdentifier(metadata, LEGACY_POWER_COLUMN);
                    try (Statement statement = connection.createStatement()) {
                        statement.executeUpdate(copySql);
                    }
                }
            }
            return null;
        });
    }

    private TableReference findTable(DatabaseMetaData metadata, Connection connection) throws SQLException {
        try (ResultSet tables = metadata.getTables(connection.getCatalog(), connection.getSchema(),
                null, new String[]{"TABLE"})) {
            while (tables.next()) {
                String tableName = tables.getString("TABLE_NAME");
                if (ADVERTISING_TABLE.equalsIgnoreCase(tableName)) {
                    return new TableReference(
                            tables.getString("TABLE_CAT"),
                            tables.getString("TABLE_SCHEM"),
                            tableName
                    );
                }
            }
        }
        return null;
    }

    private boolean hasColumn(DatabaseMetaData metadata, TableReference table, String columnName) throws SQLException {
        try (ResultSet columns = metadata.getColumns(table.catalog(), table.schema(), table.name(), null)) {
            while (columns.next()) {
                if (columnName.equalsIgnoreCase(columns.getString("COLUMN_NAME"))) {
                    return true;
                }
            }
        }
        return false;
    }

    private String quoteIdentifier(DatabaseMetaData metadata, String identifier) throws SQLException {
        String quote = metadata.getIdentifierQuoteString().trim();
        if (quote.isEmpty()) {
            return identifier;
        }
        return quote + identifier.replace(quote, quote + quote) + quote;
    }

    private record TableReference(String catalog, String schema, String name) {
    }
}

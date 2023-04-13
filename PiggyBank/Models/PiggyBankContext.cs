﻿namespace PiggyBank.Models;

public partial class PiggyBankContext : DbContext, IPiggyBankContext
{
    private string _connectionString = "";

    public PiggyBankContext(string connectionString)
    {
        _connectionString = connectionString;
    }

    public PiggyBankContext(DbContextOptions<PiggyBankContext> options) : base(options) { }

    public virtual DbSet<Account> Accounts { get; set; }
    public virtual DbSet<Configuration> Configurations { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlServer(_connectionString);
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {

        modelBuilder.Entity<Configuration>(entity =>
        {
            entity.ToTable("Configuration");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Key)
                .HasColumnType("varchar(255)")
                .HasColumnName("Key");
            entity.Property(e => e.Value)
                .HasColumnType("varchar(255)")
                .HasColumnName("Value");
        });


        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}

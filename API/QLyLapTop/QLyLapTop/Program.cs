using Microsoft.EntityFrameworkCore;
using QLyLapTop.MyModels;

var builder = WebApplication.CreateBuilder(args);

string strcnn = builder.Configuration.GetConnectionString("cnn");
builder.Services.AddDbContext<KetNoiCSDL>(options => options.UseSqlServer(strcnn));

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();
app.UseCors(builder => builder.AllowAnyHeader().AllowAnyMethod().AllowAnyOrigin());

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();

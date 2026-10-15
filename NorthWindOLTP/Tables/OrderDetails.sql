CREATE TABLE [dbo].[OrderDetails](
    [OrderID] [int] NOT NULL,
    [ProductID] [int] NOT NULL,
    [UnitPrice] [money] NOT NULL CONSTRAINT [DF_Order_Details_UnitPrice] DEFAULT ((0)),
    [Quantity] [smallint] NOT NULL CONSTRAINT [DF_Order_Details_Quantity] DEFAULT ((1)),
    [Discount] [real] NOT NULL CONSTRAINT [DF_Order_Details_Discount] DEFAULT ((0)),
    [rowversion] [timestamp] NULL,
    CONSTRAINT [PK_Order_Details] PRIMARY KEY CLUSTERED ([OrderID] ASC, [ProductID] ASC),
    CONSTRAINT [FK_Order_Details_Orders] FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Orders] ([OrderID]),
    CONSTRAINT [FK_Order_Details_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID]),
    CONSTRAINT [CK_Discount] CHECK ([Discount] >= (0) AND [Discount] <= (1)),
    CONSTRAINT [CK_Quantity] CHECK ([Quantity] > (0)),
    CONSTRAINT [CK_UnitPrice] CHECK ([UnitPrice] >= (0))
);
